import 'package:app_aluno_registro/pages/Login.dart';
import 'package:app_aluno_registro/pages/home.dart';
import 'package:app_aluno_registro/pages/sign_up.dart';
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
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: const TabBarView(
            children: [
              const SignUp(),
              const Home(),
              const Login(),
            ],
          ),
        ),
      ),
      title: 'App Aluno Registro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 72, 149, 212),
          inversePrimary: Color.fromARGB(255, 72, 149, 212),
        ),
        textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.white, fontSize: 22),
            displayMedium: TextStyle(color: Colors.white),
            displaySmall: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(fontSize: 12)),
        useMaterial3: true,
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color.fromARGB(255, 33, 150, 243),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        tabs: [
          Tab(icon: Icon(Icons.edit_square)),
          Tab(icon: Icon(Icons.home_work_rounded)),
          Tab(icon: Icon(Icons.login)),
        ],
      ),
    );
  }
}
