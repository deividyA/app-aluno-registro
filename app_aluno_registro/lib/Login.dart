import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final campo_login = TextEditingController();
  final campo_senha = TextEditingController();

  String? login;
  String? senha;

  void getControllerValues() {
    setState(() {
      login = campo_login.text;
      senha = campo_senha.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: campo_login,
                          autofocus: true,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: "Login",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          maxLines: 1,
                          maxLength: TextField.noMaxLength,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O campo Login é obrigatório.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: campo_senha,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "",
                            labelText: "Senha",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          maxLines: 1,
                          maxLength: 60,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O campo Senha é obrigatório.';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              getControllerValues();
                            }
                          },
                          child: const Text('Botao'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
