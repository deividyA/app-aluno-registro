import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final campo_numero_sere = TextEditingController();
  final campo_nome = TextEditingController();
  final campo_cpf = TextEditingController();
  final campo_rg = TextEditingController();
  final campo_nascimento = TextEditingController();
  final campo_telefone = TextEditingController();
  final campo_pai = TextEditingController();
  final campo_mae = TextEditingController();
  final campo_endereco = TextEditingController();

  double? numero_sere;
  String? nome;
  String? cpf;
  String? rg;
  String? endereco;
  DateTime? data_nascimento;
  String? telefone;
  String? pai;
  String? mae;
  List dados = [];

  void getControllerValues() {
    setState(() {
      numero_sere = double.tryParse(campo_numero_sere.text);
      nome = campo_nome.text;
      cpf = campo_cpf.text;
      rg = campo_rg.text;
      endereco = campo_endereco.text;
      data_nascimento = DateTime.tryParse(campo_nascimento.text);
      telefone = campo_telefone.text;
      pai = campo_pai.text;
      mae = campo_mae.text;
      dados = [
        numero_sere,
        nome,
        cpf,
        rg,
        endereco,
        data_nascimento,
        telefone,
        pai,
        mae
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Formulário de Cadastro',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          padding: EdgeInsets.only(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: campo_numero_sere,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Numero Sere",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    maxLines: 1,
                    maxLength: TextField.noMaxLength,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O campo Numero Sere é obrigatório.';
                      }
                      return null;
                    },
                  ),
                ),
                TextFormField(
                  controller: campo_nome,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "",
                      label: Text("Nome"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 60,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Nome é obrigatório.';
                    }
                    return null;
                  },
                ),
                MaskedTextField(
                  mask: "###.###.###-##",
                  controller: campo_cpf,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("CPF"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 14,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo CPF é obrigatório.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: campo_rg,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("RG"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 20,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo RG é obrigatório.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: campo_endereco,
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("Endereço"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 60,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Endereço é obrigatório.';
                    }
                    return null;
                  },
                ),
                MaskedTextField(
                  mask: "##/##/####",
                  controller: campo_nascimento,
                  keyboardType: TextInputType.datetime,
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("Data de Nascimento"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Data de Nascimento é obrigatório.';
                    }
                    return null;
                  },
                ),
                MaskedTextField(
                  mask: "(##) #####-####",
                  controller: campo_telefone,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("Telefone"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Telefone é obrigatório.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: campo_pai,
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("Pai (ou responsável)"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 60,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Pai é obrigatório.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: campo_mae,
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text(
                        "Mãe (ou responsável)",
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 60,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Mãe é obrigatório.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with form submission
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
    );
  }
}
