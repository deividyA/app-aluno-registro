// ignore_for_file: deprecated_member_use, use_build_context_synchronously, non_constant_identifier_names

import 'package:app_aluno_registro/pages/document_renew.dart';
import 'package:app_aluno_registro/pages/forgot_password.dart';
import 'package:app_aluno_registro/pages/home.dart';
import 'package:app_aluno_registro/pages/sign_up.dart';
import 'package:app_aluno_registro/repositories/ambiente_aluno_repository.dart';
import 'package:app_aluno_registro/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final login_store = LoginStore();
final ambiente_aluno_repository = AmbienteAlunoRepository();

class _LoginState extends State<Login> {
  late SharedPreferences prefs;

  @override
  initState() {
    initSharedPreferences();
    super.initState();
    // Updated
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? token;
  final _formKey = GlobalKey<FormState>();
  final campo_login = TextEditingController();
  final campo_senha = TextEditingController();
  bool showPassword = false;
  bool foi_tocado_senha = false;
  dynamic dados;

  List<dynamic> errorMessages = [];

  Future<void> getControllerValues() async {
    if (login_store.isValid) {
      dados = {
        'numero_sere': login_store.numeroSere,
        'senha': login_store.senha,
      };
      var resposta = await ambiente_aluno_repository.loginAluno(dados);
      if (resposta.runtimeType != String) {
        if (resposta['token'] != null) {
          token = resposta['token'];
          await prefs.setString('token', token!);
          await prefs.setInt('numero_sere', login_store.numeroSere!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else {
          resposta.forEach((key, value) {
            errorMessages = [value];
          });
          setState(() {});
        }
      } else {
        errorMessages = [resposta];
        setState(() {});
      }
    } else {
      foi_tocado_senha = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (_) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          errorMessages.isNotEmpty
                              ? errorMessages.join(', ').toString()
                              : '',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ));
                  }),
                  Observer(builder: (_) {
                    return TextField(
                      controller: campo_login,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      onChanged: (value) => login_store.setNumeroSere(value),
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Numero Sere",
                        errorText: login_store.validateNumeroSere(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      maxLines: 1,
                      maxLength: TextField.noMaxLength,
                    );
                  }),
                  Observer(builder: (_) {
                    return TextField(
                      controller: campo_senha,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) => login_store.senha = value,
                      onTap: () => {
                        foi_tocado_senha == false
                            ? setState(() {
                                foi_tocado_senha = true;
                              })
                            : '',
                      },
                      obscureText:
                          !showPassword, // Set the obscureText based on showPassword.
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Senha",
                        errorText: foi_tocado_senha
                            ? login_store.validateSenha()
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        // Add the IconButton to the suffixIcon property.
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword =
                                  !showPassword; // Toggle the showPassword state.
                            });
                          },
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color:
                                showPassword ? Colors.lightBlue : Colors.grey,
                            // Use light blue color when the password is visible (enabled).
                          ),
                        ),
                      ),
                      maxLines: 1,
                      maxLength: 60,
                    );
                  }),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DocumentRenew()),
                              );
                            },
                            child: const Text(
                              'Renovar documentos',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()),
                              );
                            },
                            child: const Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ]),
                  ElevatedButton(
                    onPressed: () {
                      getControllerValues();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.inversePrimary,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: const SizedBox(
                      width: double
                          .infinity, // Button expands to the full width of its parent
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text(
                        'Ainda não tem um cadastro? Registre-se',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
