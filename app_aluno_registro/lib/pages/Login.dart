import 'package:app_aluno_registro/pages/forgot-password.dart';
import 'package:app_aluno_registro/pages/home.dart';
import 'package:app_aluno_registro/pages/sign_up.dart';
import 'package:app_aluno_registro/repositories/ambiente_aluno_repository.dart';
import 'package:app_aluno_registro/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final login_store = LoginStore();
final ambiente_aluno_repository = AmbienteAlunoRepository();

class _LoginState extends State<Login> {
  void initState() {
    super.initState();
    // Updated
  }

  final _formKey = GlobalKey<FormState>();
  final campo_login = TextEditingController();
  final campo_senha = TextEditingController();
  bool showPassword = false;
  bool foi_tocado_senha = false;
  var dados;
  var token;
  List<dynamic> errorMessages = [];

  Future<void> getControllerValues() async {
    if (login_store.isValid) {
      dados = {
        'numero_sere': login_store.numeroSere,
        'senha': login_store.senha,
      };
      var resposta = await ambiente_aluno_repository.loginAluno(dados);

      if (resposta.length > 0) {
        if (resposta['token'] != null) {
          login_store.token = resposta['token'];
          if (login_store.token != null && login_store.token != '') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }
        } else {
          resposta.forEach((key, value) {
            errorMessages = [value];
          });
          print(errorMessages);
          setState(() {});
        }
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
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          errorMessages.length > 0
                              ? errorMessages.join(', ').toString()
                              : '',
                          style: TextStyle(color: Colors.red, fontSize: 12),
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
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()),
                          );
                        },
                        child: Text(
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
                    child: SizedBox(
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
                    padding: EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
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
