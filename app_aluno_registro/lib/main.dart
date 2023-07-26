import 'package:app_aluno_registro/pages/home.dart';
import 'package:app_aluno_registro/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return FutureBuilder<String?>(
      future: transmiteToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still resolving, you can show a loading indicator if desired.
          return CircularProgressIndicator();
        } else if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data == '') {
          // Handle the error or the case where the token is null or empty (not logged in)
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
            home: const Login(),
          );
        } else {
          // If the token exists and is not empty, navigate to Home
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
