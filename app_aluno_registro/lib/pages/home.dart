import 'dart:convert';
import 'dart:ffi';

import 'package:app_aluno_registro/models/aluno.dart';
import 'package:app_aluno_registro/repositories/aluno_repository.dart';
import 'package:app_aluno_registro/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
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

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    numero_sere = await prefs.getInt('numero_sere');
    await pegaDadosAluno(token, numero_sere);
  }

  pegaDadosAluno(token, numero_sere) async {
    dados = await aluno_repository.getAlunos(token, numero_sere);
    if (dados != null) {
      print(dados[0]);
    }
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
          child: FlipCard(
            key: _cardKey,
            direction: FlipDirection.HORIZONTAL,
            front: const CardFront(),
            back: const CardBack(),
          ),
        ),
      ),
    );
  }
}

class CardFront extends StatelessWidget {
  const CardFront({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1.0, // Set the desired width
      height:
          MediaQuery.of(context).size.height * 0.45, // Set the desired height
      child: Card(
        margin: const EdgeInsets.all(20.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Title at Top Right', // Replace with your title
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add any other widgets for the top right section
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Escola:',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Nome:',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Pai:',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Mãe:',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Turno:',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'D.Nasc:',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Série:',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Sexo:',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SERE:',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Fone:',
                          style: TextStyle(
                            fontSize: 12,
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
  const CardBack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Set the desired width
      height: 200, // Set the desired height
      child: Card(
        margin: const EdgeInsets.all(20.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Back Side',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16), // Add some spacing
              Text(
                'Additional Information', // Replace with any additional text
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
