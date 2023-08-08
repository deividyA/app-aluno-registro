import 'package:app_aluno_registro/pages/home.dart';
import 'package:app_aluno_registro/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Tema global
    return FutureBuilder<String?>(
      future: transmiteToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // esperando a conexão
          return const CircularProgressIndicator();
        } else if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data == '') {
          return MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 72, 149, 212),
                inversePrimary: const Color.fromARGB(255, 72, 149, 212),
              ),
              textTheme: const TextTheme(
                //Utilizado em Titulos do AppBar
                displayLarge: TextStyle(color: Colors.white, fontSize: 22),
                //Utilizado em titulos de cards
                displayMedium:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //Utilizado em body de cards
                displaySmall: TextStyle(fontSize: 10),
                //Utilizado em Formularios
                bodyMedium: TextStyle(fontSize: 20),
                //Botoes de arquivos
                headlineSmall: TextStyle(fontSize: 20, color: Colors.white),
                //Utilizado em Erros em forma de texto
                labelLarge: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                //labelMedium utilizado para links e redirecionamento
                labelMedium: TextStyle(color: Colors.blue, fontSize: 18),
                //Utilizado em Botão/Botoes
                bodyLarge: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              useMaterial3: true,
            ),
            home: const Login(),
          );
        } else {
          // se tem token vai pra home
          return MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 72, 149, 212),
                inversePrimary: const Color.fromARGB(255, 72, 149, 212),
              ),
              textTheme: const TextTheme(
                //Utilizado em Titulos do AppBar
                displayLarge: TextStyle(color: Colors.white, fontSize: 22),
                //Utilizado em titulos de cards
                displayMedium:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //Utilizado em body de cards
                displaySmall: TextStyle(fontSize: 10),
                //Utilizado em Formularios
                bodyMedium: TextStyle(fontSize: 20),
                //Botoes de arquivos
                headlineSmall: TextStyle(fontSize: 20, color: Colors.white),
                //Utilizado em Erros em forma de texto
                labelLarge: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                //labelMedium utilizado para links e redirecionamento
                labelMedium: TextStyle(color: Colors.blue, fontSize: 18),
                //Utilizado em Botão/Botoes
                bodyLarge: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              useMaterial3: true,
            ),
            home: const Home(),
          );
        }
      },
    );
  }

  Future<String?> transmiteToken() async {
    String? token = await pegaToken();
    return token;
  }

  Future<String?> pegaToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }
}
