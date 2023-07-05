import 'package:app_aluno_registro/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Aluno Registro',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(2, 136, 209, 255)),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
