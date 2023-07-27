import 'package:qr_flutter/qr_flutter.dart';
import 'package:app_aluno_registro/repositories/aluno_repository.dart';
import 'package:app_aluno_registro/stores/login_store.dart';
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
  dynamic dados;

  @override
  initState() {
    initSharedPreferences();
    super.initState();
  }

  Future<dynamic> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    numero_sere = await prefs.getInt('numero_sere');
    if (await prefs.getString('nome') != null) {
      dados[0]['nome'] = await prefs.getString('nome');
      dados[0]['escola'] = await prefs.getString('escola');
      dados[0]['pai'] = await prefs.getString('pai');
      dados[0]['mae'] = await prefs.getString('mae');
      dados[0]['turno'] = await prefs.getString('turno');
      dados[0]['data_nascimento'] = await prefs.getString('data_nascimento');
      dados[0]['serie'] = await prefs.getString('serie');
      dados[0]['sexo'] = await prefs.getString('sexo');
      dados[0]['numero_sere'] = await prefs.getString('numero_sere');
      dados[0]['fone_residencial'] = await prefs.getString('fone_residencial');
    } else {
      await pegaDadosAluno(token, numero_sere);
    }
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
    await prefs.setString('numero_sere', dados[0]['numero_sere']);
    await prefs.setString('fone_residencial', dados[0]['fone_residencial']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Area do Aluno',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Center(
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0) {
              // Swipe to the right
              _cardKey.currentState!.toggleCard();
            } else if (details.delta.dx < 0) {
              // Swipe to the left
              _cardKey.currentState!.toggleCard();
            }
          },
          child: FutureBuilder<dynamic>(
            future: initSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading indicator while waiting for dados
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (dados != null) {
                return FlipCard(
                  key: _cardKey,
                  direction: FlipDirection.HORIZONTAL,
                  front: CardFront(dados: dados[0]),
                  back: CardBack(dados: dados[0]),
                );
              } else {
                return Text('No data found.');
              }
            },
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
      width: MediaQuery.of(context).size.width * 1.0, // Set the desired width
      height:
          MediaQuery.of(context).size.height * 0.45, // Set the desired height
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
                    'Titulo', // Replace with your title
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add any other widgets for the top right section
                ],
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Escola: ${dados['escola']}',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Nome: ${dados['nome']}',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Pai: ${dados['pai']}',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Mãe: ${dados['mae']}',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Turno: ${dados['turno']}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'D.Nasc: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(dados['data_nascimento']))}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Série: ${dados['serie']}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'Sexo: ${dados['sexo']}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SERE:${dados['numero_sere']}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'Fone: ${dados['fone_residencial']}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
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
