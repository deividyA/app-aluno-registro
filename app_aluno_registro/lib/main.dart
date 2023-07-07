import 'package:app_aluno_registro/Login.dart';
import 'package:app_aluno_registro/home.dart';
import 'package:app_aluno_registro/sign_up.dart';
import 'package:flutter/material.dart';

//first code to be executed(by default)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Global theme that can be used
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              labelColor: Color.fromARGB(255, 83, 127, 155),
              tabs: [
                Tab(icon: Icon(Icons.edit_square)),
                Tab(icon: Icon(Icons.login)),
                Tab(icon: Icon(Icons.home_work_rounded)),
                //Tab(icon: Icon(Icons.build)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              const SignUp(),
              const Login(),
              const Home(),
            ],
          ),
        ),
      ),
      title: 'App Aluno Registro',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(236, 239, 241, 255),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(2, 136, 209, 255)),
        textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.white, fontSize: 30),
            displayMedium: TextStyle(color: Colors.white),
            displaySmall: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(fontSize: 35)),
        useMaterial3: true,
      ),
    );
  }
}
