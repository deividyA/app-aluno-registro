import 'package:app_aluno_registro/pages/sign_up.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Text(
          'Ai tu se fodeu pq eu n fiz essa pagina ainda amigo',
          style: TextStyle(fontSize: 30),
        ),
      ),
    ));
  }
}
