import 'dart:convert';
import 'package:app_aluno_registro/repositories/ambiente_aluno_repository.dart';
import 'package:app_aluno_registro/stores/sign_up_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:masked_text/masked_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    atribui_municipios();
    super.initState();
    // Updated
  }

  final signUpStore = SignUpStore();

  var ambiente_aluno;
  List<dynamic>? lista_municipios;

  Future<void> atribui_municipios() async {
    ambiente_aluno = AmbienteAlunoRepository();
    lista_municipios = await ambiente_aluno.getMunicipios();
    print(lista_municipios);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final campo_numero_sere = TextEditingController();
  final campo_nome = TextEditingController();
  final campo_cpf = TextEditingController();
  final campo_rg = TextEditingController();
  final campo_nascimento = TextEditingController();
  final campo_telefone = TextEditingController();
  final campo_email = TextEditingController();
  String? campo_sexo;
  final campo_pai = TextEditingController();
  final campo_mae = TextEditingController();
  dynamic? campo_municipio;
  final campo_endereco = TextEditingController();
  final campo_bairro = TextEditingController();
  final campo_cep = TextEditingController();

  double? numero_sere;
  String? nome;
  String? cpf;
  String? rg;
  DateTime? data_nascimento;
  String? telefone;
  String? email;
  String? sexo;
  String? pai;
  String? mae;
  String? endereco;
  String? bairro;
  String? cep;
  List dados = [];

  getControllerValues() {
    // setState(() {
    //   numero_sere = double.tryParse(campo_numero_sere.text);
    //   nome = campo_nome.text;
    //   cpf = campo_cpf.text;
    //   rg = campo_rg.text;
    //   data_nascimento = DateTime.tryParse(campo_nascimento.text);
    //   telefone = campo_telefone.text;
    //   email = campo_email.text;
    //   sexo = campo_sexo;
    //   pai = campo_pai.text;
    //   mae = campo_mae.text;
    //   campo_municipio = campo_municipio;
    //   endereco = campo_endereco.text;
    //   bairro = campo_bairro.text;
    //   cep = campo_cep.text;
    //   dados = [
    //     numero_sere,
    //     nome,
    //     cpf,
    //     rg,
    //     data_nascimento,
    //     telefone,
    //     email,
    //     sexo,
    //     pai,
    //     mae,
    //     campo_municipio,
    //     endereco,
    //     bairro,
    //     cep
    //   ];
    // });
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
                  child: Observer(
                    builder: (_) => TextField(
                      controller: campo_numero_sere,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => signUpStore.setNumeroSere(value),
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Numero Sere",
                        errorText: signUpStore.validateNumeroSere(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      maxLines: 1,
                      maxLength: TextField.noMaxLength,
                    ),
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
                  controller: campo_email,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("E-mail"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 60,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo E-mail é obrigatório.';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: campo_sexo,
                  onChanged: (newValue) {
                    setState(() {
                      campo_sexo = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Sexo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem<String>(
                      value: "M",
                      child: Text("Masculino"),
                    ),
                    DropdownMenuItem<String>(
                      value: "F",
                      child: Text("Feminino"),
                    ),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'O campo Município é obrigatório.';
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
                TextFormField(
                  controller: campo_cep,
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("CEP"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 8,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo CEP é obrigatório.';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: campo_municipio,
                  onChanged: (newValue) {
                    setState(() {
                      campo_municipio = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Município',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  items: lista_municipios?.map((municipio) {
                    return DropdownMenuItem<String>(
                      value: municipio['municipio_codigo_ibge'],
                      child: Text(municipio['nome']),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'O campo Município é obrigatório.';
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
                TextFormField(
                  controller: campo_bairro,
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("Bairro"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  maxLines: 1,
                  maxLength: 60,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo Bairro é obrigatório.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    getControllerValues();
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
