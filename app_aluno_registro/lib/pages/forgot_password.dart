// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'package:app_aluno_registro/common.dart';
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

        Common.displayError(
            context, 'Erro!', errorMessages.join(', ').toString());
      } else {
        Common.displaySuccess(
            context, 'Sucesso!!', 'Siga os passos no seu e-mail', true);
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
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.025),
                  child: Text(
                    'Preencha os dados de sua conta e lhe enviaremos um email de recuperação.',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Observer(builder: (_) {
                    return TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      controller: campo_numero_sere,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      onChanged: (value) =>
                          forgotPasswordStore.setNumeroSere(value),
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Recuperar Senha',
                        style: Theme.of(context).textTheme.bodyLarge,
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
