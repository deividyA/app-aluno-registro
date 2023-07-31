// ignore_for_file: non_constant_identifier_names
import 'package:app_aluno_registro/repositories/ambiente_aluno_repository.dart';
import 'package:app_aluno_registro/stores/forgot_password_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  @override
  void initState() {
    super.initState();
  }

  final forgotPasswordStore = ForgotPasswordStore();

  dynamic ambiente_aluno = AmbienteAlunoRepository();

  List<dynamic>? lista_municipios;
  dynamic index_municipio_cep;

  bool foi_tocado_email = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final campo_numero_sere = TextEditingController();
  final campo_email = TextEditingController();
  dynamic dados;

  getControllerValues() async {
    if (forgotPasswordStore.isValid) {
      dados = {
        'numero_sere': forgotPasswordStore.numeroSere,
        'email': forgotPasswordStore.email,
      };
      final response = await ambiente_aluno.esqueceuSenha(dados);

      List<dynamic> errorMessages = [];

      if (response != null) {
        response.forEach((key, value) {
          errorMessages.addAll(value);
        });
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 244, 67, 54)
                        .withOpacity(1.0), // 100% red
                    const Color.fromARGB(255, 250, 126, 117).withOpacity(1.0),
                  ],
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align title to the left
                children: [
                  Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Align icon to the right
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 5, top: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ))
                      ]),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          'Erro!!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      errorMessages.join(', ').toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      foi_tocado_email = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Esqueceu sua Senha?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.only(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                    'Preencha os dados de sua conta e lhe enviaremos um email de recuperação.'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Observer(builder: (_) {
                    return TextField(
                      controller: campo_numero_sere,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      onChanged: (value) =>
                          forgotPasswordStore.setNumeroSere(value),
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Numero Sere",
                        errorText: forgotPasswordStore.validateNumeroSere(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      maxLines: 1,
                      maxLength: TextField.noMaxLength,
                    );
                  }),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => forgotPasswordStore.email = value,
                    onTap: () => {
                      foi_tocado_email == false
                          ? setState(() {
                              foi_tocado_email = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: const Text("Email"),
                        errorText: foi_tocado_email
                            ? forgotPasswordStore.validateEmail()
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 60,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    getControllerValues();
                  },
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: Theme.of(context).colorScheme.inversePrimary,
                    // ignore: deprecated_member_use
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: const SizedBox(
                    width: double
                        .infinity, // Button expands to the full width of its parent
                    child: Center(
                      child: Text(
                        'Recuperar Senha',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
