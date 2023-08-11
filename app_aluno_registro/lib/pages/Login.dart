// ignore_for_file: deprecated_member_use, use_build_context_synchronously, non_constant_identifier_names, file_names
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
    login_store.enviar = true;
    initSharedPreferences();
    super.initState();
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
  bool enviar = true;
  dynamic dados;

  List<dynamic> errorMessages = [];

  Future<void> getControllerValues() async {
    if (login_store.isValid) {
      login_store.enviar = false;
      setState(() {});
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
      login_store.enviar = true;
      setState(() {});
    } else {
      foi_tocado_senha = true;
      setState(() {});
    }
    enviar = true;
  }

  habilitaBotao() {
    return login_store.enviar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                        height: MediaQuery.of(context).size.height * 0.09,
                        fit: BoxFit.fitHeight,
                        'assets/images/LOGO_BZS.png'),
                  ),
                  Observer(builder: (_) {
                    return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.030,
                            top: MediaQuery.of(context).size.height * 0.030),
                        child: Text(
                          errorMessages.isNotEmpty
                              ? errorMessages.join(', ').toString()
                              : '',
                          style: Theme.of(context).textTheme.labelLarge,
                        ));
                  }),
                  Observer(builder: (_) {
                    return TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      controller: campo_login,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      onChanged: (value) => login_store.setNumeroSere(value),
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        isDense: true,
                        labelText: "Senha",
                        errorText: foi_tocado_senha
                            ? login_store.validateSenha()
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color:
                                showPassword ? Colors.lightBlue : Colors.grey,
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
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005,
                              top: MediaQuery.of(context).size.height * 0.005),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DocumentRenew()),
                              );
                            },
                            child: Text('Renovar documentos',
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005,
                              top: MediaQuery.of(context).size.height * 0.005),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()),
                              );
                            },
                            child: Text(
                              'Esqueci minha senha',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ]),
                  ElevatedButton(
                    onPressed: habilitaBotao()
                        ? () {
                            getControllerValues();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.inversePrimary,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: habilitaBotao()
                            ? Text(
                                'Cadastrar',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            : CircularProgressIndicator(),
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
                      child: Text(
                        'Ainda não tem um cadastro? Registre-se',
                        style: Theme.of(context).textTheme.labelMedium,
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
