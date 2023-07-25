import 'package:app_aluno_registro/pages/home.dart';
import 'package:app_aluno_registro/pages/login.dart';
import 'package:flutter/material.dart';

// First code to be executed (by default)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Global theme that can be used
    String? token = verificaToken();
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 72, 149, 212),
          inversePrimary: const Color.fromARGB(255, 72, 149, 212),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontSize: 22),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(fontSize: 12),
        ),
        useMaterial3: true,
      ),
      home: token != null && token != '' ? const Home() : const Login(),
    );
  }

  String? verificaToken() {
    return login_store.token;
  }
}
