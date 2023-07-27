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
      child: const Center(
        child: Text(
          'teste',
          style: TextStyle(fontSize: 30),
        ),
      ),
    ));
  }
}
