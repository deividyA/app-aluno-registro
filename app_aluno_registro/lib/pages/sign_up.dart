import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:app_aluno_registro/repositories/ambiente_aluno_repository.dart';
import 'package:app_aluno_registro/stores/sign_up_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:masked_text/masked_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  final mask_cpf = MaskTextInputFormatter(mask: '###.###.###-##');
  final mask_telefone = MaskTextInputFormatter(mask: "(##) #####-####");

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
                Observer(
                  builder: (_) => TextField(
                    controller: campo_nome,
                    keyboardType: TextInputType.name,
                    onChanged: (value) => signUpStore.nome = value,
                    decoration: InputDecoration(
                        isDense: true,
                        labelText: "Nome",
                        errorText: signUpStore.validateNome(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 60,
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_cpf,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    autofocus: true,
                    inputFormatters: [mask_cpf],
                    onChanged: (value) =>
                        signUpStore.cpf = mask_cpf.getUnmaskedText(),
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("CPF"),
                        errorText: signUpStore.validateCpf(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 14,
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_rg,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    onChanged: (value) => signUpStore.rg = value,
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("RG"),
                        errorText: signUpStore.validateRg(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 20,
                  ),
                ),
                Observer(
                  builder: (_) => MaskedTextField(
                    mask: "##/##/####",
                    controller: campo_nascimento,
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) => value.length == 10
                        ? signUpStore.dataNascimento =
                            DateFormat('dd/MM/yyyy').parse(value)
                        : signUpStore.dataNascimento = null,
                    autofocus: true,
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Data de Nascimento"),
                        errorText: signUpStore.validateDataNascimento(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 10,
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_telefone,
                    inputFormatters: [mask_telefone],
                    onChanged: (value) =>
                        signUpStore.telefone = mask_telefone.getUnmaskedText(),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    autofocus: true,
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Telefone"),
                        errorText: signUpStore.validateTelefone(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 15,
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => signUpStore.email = value,
                    autofocus: true,
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("E-mail"),
                        errorText: signUpStore.validateEmail(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 60,
                  ),
                ),
                Observer(
                  builder: (_) => DropdownButtonFormField<String>(
                    value: campo_sexo,
                    onChanged: (newValue) {
                      setState(() {
                        campo_sexo = newValue;
                      });
                      signUpStore.sexo = newValue;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Sexo',
                      errorText: signUpStore.validateSexo(),
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
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_pai,
                    onChanged: (value) => signUpStore.pai = value,
                    autofocus: true,
                    decoration: InputDecoration(
                        isDense: true,
                        errorText: signUpStore.validatePai(),
                        label: Text("Pai (ou responsável)"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 60,
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_mae,
                    onChanged: (value) => signUpStore.mae = value,
                    autofocus: true,
                    decoration: InputDecoration(
                        isDense: true,
                        errorText: signUpStore.validateMae(),
                        label: Text(
                          "Mãe (ou responsável)",
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 60,
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_cep,
                    onChanged: (value) => signUpStore.cep = value,
                    autofocus: true,
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("CEP"),
                        errorText: signUpStore.validateCep(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 8,
                  ),
                ),
                Observer(
                  builder: (_) => DropdownButtonFormField<String>(
                    value: campo_municipio,
                    onChanged: (newValue) {
                      setState(() {
                        campo_municipio = newValue;
                      });
                      signUpStore.municipio = newValue;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Município',
                      errorText: signUpStore.validateMunicipio(),
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
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_endereco,
                    autofocus: true,
                    onChanged: (value) => signUpStore.endereco = value,
                    decoration: InputDecoration(
                        isDense: true,
                        errorText: signUpStore.validateEndereco(),
                        label: Text("Endereço"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 60,
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_bairro,
                    autofocus: true,
                    onChanged: (value) => signUpStore.bairro = value,
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Bairro"),
                        errorText: signUpStore.validateBairro(),
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
