// ignore_for_file: non_constant_identifier_names, await_only_futures, use_build_context_synchronously

import 'package:app_aluno_registro/common.dart';
import 'package:app_aluno_registro/pages/login.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:app_aluno_registro/repositories/aluno_repository.dart';
import 'package:app_aluno_registro/stores/login_store.dart';
import 'package:app_aluno_registro/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;
  late String? token;
  late int? numero_sere;
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  final aluno_repository = AlunoRepository();
  final login_store = LoginStore();
  final home_store = HomeStore();
  dynamic dados;

  @override
  initState() {
    initSharedPreferences();
    super.initState();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    numero_sere = await prefs.getInt('numero_sere');

    if (await prefs.getString('nome') != null) {
      int ano = DateTime.now().year;
      int? ano1 = await prefs.getInt('ano1');
      int? ano2 = await prefs.getInt('ano2');
      int? ano3 = await prefs.getInt('ano3');

      if (ano != ano1 && ano != ano2 && ano != ano3) {
        await prefs.remove('token');
        await prefs.remove('nome');
        login_store.senha = null;
        login_store.numeroSere = null;

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );

        Common.displayError(context, 'Erro!!',
            'Sua carteirinha não foi atualizada para este ano!, Por favor Renove os Documentos.');
      }

      dados = [{}];
      dados[0]['nome'] = await prefs.getString('nome');
      dados[0]['escola'] = await prefs.getString('escola');
      dados[0]['pai'] = await prefs.getString('pai');
      dados[0]['mae'] = await prefs.getString('mae');
      dados[0]['turno'] = await prefs.getString('turno');
      dados[0]['data_nascimento'] = await prefs.getString('data_nascimento');
      dados[0]['serie'] = await prefs.getString('serie');
      dados[0]['sexo'] = await prefs.getString('sexo');
      dados[0]['numero_sere'] = numero_sere;
      dados[0]['fone_residencial'] = await prefs.getString('fone_residencial');
      dados[0]['json_build_object'] =
          await prefs.getString('json_build_object');
    } else {
      await pegaDadosAluno(token, numero_sere);
    }

    Future.delayed(const Duration(seconds: 2), () {
      home_store.welcome_card = false;
    });
  }

  pegaDadosAluno(token, numero_sere) async {
    dados = await aluno_repository.getAlunos(token, numero_sere);
    await prefs.setString('nome', dados[0]['nome']);
    await prefs.setString('escola', dados[0]['escola']);
    await prefs.setString('pai', dados[0]['pai']);
    await prefs.setString('mae', dados[0]['mae']);
    await prefs.setString('turno', dados[0]['turno']);
    await prefs.setString('data_nascimento', dados[0]['data_nascimento']);
    await prefs.setString('serie', dados[0]['serie']);
    await prefs.setString('sexo', dados[0]['sexo']);
    await prefs.setString('fone_residencial', dados[0]['fone_residencial']);
    await prefs.setString(
        'json_build_object', dados[0]['json_build_object'].toString());
    if (dados[0]['ano1'] != null) {
      await prefs.setInt('ano1', dados[0]['ano1']);
    }
    if (dados[0]['ano2'] != null) {
      await prefs.setInt('ano2', dados[0]['ano2']);
    }
    if (dados[0]['ano3'] != null) {
      await prefs.setInt('ano3', dados[0]['ano3']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Area do Aluno',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/HOME_BACKGROUND.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                // Swipe direita
                _cardKey.currentState!.toggleCard();
              } else if (details.delta.dx < 0) {
                // Swipe esquerda
                _cardKey.currentState!.toggleCard();
              }
            },
            child: Column(
              children: [
                FutureBuilder<dynamic>(
                  future: initSharedPreferences(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (dados != null) {
                      return Column(children: [
                        Observer(builder: (_) {
                          return AnimatedOpacity(
                            opacity: home_store.welcome_card ? 1.0 : 0.0,
                            duration: const Duration(seconds: 2),
                            child: Card(
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                      "Boas Vindas!! :) \n ${dados[0]['nome']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge),
                                ),
                              ),
                            ),
                          );
                        }),
                        FlipCard(
                          key: _cardKey,
                          direction: FlipDirection.HORIZONTAL,
                          front: CardFront(dados: dados[0]),
                          back: CardBack(dados: dados[0]),
                        ),
                      ]);
                    } else {
                      return const Text('No data found.');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardFront extends StatelessWidget {
  final dynamic dados;

  const CardFront({Key? key, required this.dados}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shadowColor: Colors.black,
        margin: const EdgeInsets.all(20.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Titulo',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Escola: ${dados['escola']}',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      'Nome: ${dados['nome']}',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      'Pai: ${dados['pai']}',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      'Mãe: ${dados['mae']}',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Turno: ${dados['turno']}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'D.Nasc: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(dados['data_nascimento']))}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Série: ${dados['serie']}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'Sexo: ${dados['sexo']}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SERE:${dados['numero_sere']}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'Fone: ${dados['fone_residencial']}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  final dynamic dados;

  const CardBack({Key? key, required this.dados}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shadowColor: Colors.black,
        margin: const EdgeInsets.all(20.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImageView(
                data: dados['json_build_object'],
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.longestSide / 3,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
