import 'package:app_aluno_registro/repositories/cep_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:app_aluno_registro/repositories/ambiente_aluno_repository.dart';
import 'package:app_aluno_registro/stores/sign_up_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:masked_text/masked_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

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
  var index_municipio_cep;

  Future<void> atribui_municipios() async {
    ambiente_aluno = AmbienteAlunoRepository();
    lista_municipios = await ambiente_aluno.getMunicipios();
  }

  pegaDadosCep(cep) async {
    var cep_api = CepRepository();
    var cep_buscado = await cep_api.buscarCep(cep);
    if (cep_buscado != null) {
      return cep_buscado;
    } else {
      return 'Cep não encontrado';
    }
  }

  final mask_cpf = MaskTextInputFormatter(mask: '###.###.###-##');
  final mask_telefone = MaskTextInputFormatter(mask: "(##) #####-####");
  final mask_cep = MaskTextInputFormatter(mask: '#####-###');
  bool foi_tocado_nome = false;
  bool foi_tocado_cpf = false;
  bool foi_tocado_rg = false;
  bool foi_tocado_nascimento = false;
  bool foi_tocado_telefone = false;
  bool foi_tocado_email = false;
  bool foi_tocado_sexo = false;
  bool foi_tocado_pai = false;
  bool foi_tocado_mae = false;
  bool foi_tocado_municipio = false;
  bool foi_tocado_endereco = false;
  bool foi_tocado_bairro = false;
  bool foi_tocado_cep = false;
  bool foi_tocado_senha = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final campo_numero_sere = TextEditingController();
  final campo_senha = TextEditingController();
  bool showPassword = false;
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

  var dados_cep;
  var dados;

  getControllerValues() async {
    if (signUpStore.isValid) {
      dados = {
        'numero_sere': signUpStore.numeroSere,
        'senha': signUpStore.senha,
        'nome': signUpStore.nome,
        'nome_razao_social': signUpStore.nome,
        'cpf': signUpStore.cpf,
        'rg': signUpStore.rg,
        'data_nascimento': signUpStore.dataNascimento,
        'telefone': signUpStore.telefone,
        'email': signUpStore.email,
        'sexo_fk': signUpStore.sexo,
        'pai': signUpStore.pai,
        'mae': signUpStore.mae,
        'municipio_codigo_ibge': signUpStore.municipio,
        'endereco': signUpStore.endereco,
        'bairro': signUpStore.bairro,
        'cep': signUpStore.cep,
      };
      final response = await ambiente_aluno.cadastraAluno(dados);

      List<dynamic> errorMessages = [];

      // Check the response status and show the success/error pop-up accordingly
      if (response != null) {
        response.forEach((key, value) {
          errorMessages.addAll(value);
        });
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
                    Color.fromARGB(255, 244, 67, 54)
                        .withOpacity(1.0), // 100% red
                    Color.fromARGB(255, 250, 126, 117).withOpacity(1.0),
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
                            padding: EdgeInsets.only(right: 5, top: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ))
                      ]),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      errorMessages.join(', ').toString(),
                      style: TextStyle(
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
      foi_tocado_senha = true;
      foi_tocado_nome = true;
      foi_tocado_cpf = true;
      foi_tocado_rg = true;
      foi_tocado_nascimento = true;
      foi_tocado_telefone = true;
      foi_tocado_email = true;
      foi_tocado_sexo = true;
      foi_tocado_pai = true;
      foi_tocado_mae = true;
      foi_tocado_municipio = true;
      foi_tocado_endereco = true;
      foi_tocado_bairro = true;
      foi_tocado_cep = true;
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
                  child: Observer(builder: (_) {
                    return TextField(
                      controller: campo_numero_sere,
                      keyboardType: TextInputType.number,
                      autofocus: true,
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
                    );
                  }),
                ),
                Observer(builder: (_) {
                  return TextField(
                    controller: campo_senha,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) => signUpStore.senha = value,
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
                      errorText:
                          foi_tocado_senha ? signUpStore.validateSenha() : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                          color: showPassword ? Colors.lightBlue : Colors.grey,
                          // Use light blue color when the password is visible (enabled).
                        ),
                      ),
                    ),
                    maxLines: 1,
                    maxLength: 60,
                  );
                }),
                Observer(builder: (_) {
                  return TextField(
                    controller: campo_nome,
                    keyboardType: TextInputType.name,
                    onChanged: (value) => signUpStore.nome = value,
                    onTap: () => {
                      foi_tocado_nome == false
                          ? setState(() {
                              foi_tocado_nome = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        labelText: "Nome",
                        errorText:
                            foi_tocado_nome ? signUpStore.validateNome() : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 60,
                  );
                }),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_cpf,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    inputFormatters: [mask_cpf],
                    onChanged: (value) =>
                        signUpStore.cpf = mask_cpf.getUnmaskedText(),
                    onTap: () => {
                      foi_tocado_cpf == false
                          ? setState(() {
                              foi_tocado_cpf = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("CPF"),
                        errorText:
                            foi_tocado_cpf ? signUpStore.validateCpf() : null,
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
                    onChanged: (value) => signUpStore.rg = value,
                    onTap: () => {
                      foi_tocado_rg == false
                          ? setState(() {
                              foi_tocado_rg = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Rg"),
                        errorText:
                            foi_tocado_rg ? signUpStore.validateRg() : null,
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
                        ? signUpStore.dataNascimento = DateFormat('yyyy-MM-dd')
                            .format(DateFormat('dd/MM/yyyy').parse(value))
                        : signUpStore.dataNascimento = null,
                    onTap: () => {
                      foi_tocado_nascimento == false
                          ? setState(() {
                              foi_tocado_nascimento = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Data de Nascimento"),
                        errorText: foi_tocado_nascimento
                            ? signUpStore.validateDataNascimento()
                            : null,
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
                    onTap: () => {
                      foi_tocado_telefone == false
                          ? setState(() {
                              foi_tocado_telefone = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Telefone"),
                        errorText: foi_tocado_telefone
                            ? signUpStore.validateTelefone()
                            : null,
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
                    onTap: () => {
                      foi_tocado_email == false
                          ? setState(() {
                              foi_tocado_email = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Email"),
                        errorText: foi_tocado_email
                            ? signUpStore.validateEmail()
                            : null,
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
                    onTap: () => {
                      foi_tocado_sexo == false
                          ? setState(() {
                              foi_tocado_sexo = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Sexo"),
                        errorText:
                            foi_tocado_sexo ? signUpStore.validateSexo() : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
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
                Text(' '),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_pai,
                    onChanged: (value) => signUpStore.pai = value,
                    onTap: () => {
                      foi_tocado_pai == false
                          ? setState(() {
                              foi_tocado_pai = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Pai"),
                        errorText:
                            foi_tocado_pai ? signUpStore.validatePai() : null,
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
                    onTap: () => {
                      foi_tocado_mae == false
                          ? setState(() {
                              foi_tocado_mae = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Mãe"),
                        errorText:
                            foi_tocado_mae ? signUpStore.validateMae() : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 60,
                  ),
                ),
                Observer(
                  builder: (_) => TextField(
                    inputFormatters: [mask_cep],
                    controller: campo_cep,
                    keyboardType: TextInputType.number,
                    onChanged: (value) async => {
                      signUpStore.cep = mask_cep.getUnmaskedText(),
                      if (signUpStore.cep!.length == 8)
                        {
                          dados_cep =
                              await pegaDadosCep(mask_cep.getUnmaskedText()),
                          campo_endereco.text = dados_cep.logradouro,
                          campo_bairro.text = dados_cep.bairro,
                          index_municipio_cep = lista_municipios?.indexWhere(
                            (municipio) =>
                                municipio['municipio_codigo_ibge'] ==
                                dados_cep.ibge,
                          ),
                          index_municipio_cep != null &&
                                  index_municipio_cep >= 0
                              ? setState(() {})
                              : null,
                          signUpStore.municipio =
                              lista_municipios![index_municipio_cep]
                                  ['municipio_codigo_ibge']
                        }
                    },
                    onTap: () => {
                      foi_tocado_cep == false
                          ? setState(() {
                              foi_tocado_cep = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("CEP"),
                        errorText:
                            foi_tocado_cep ? signUpStore.validateCep() : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    maxLines: 1,
                    maxLength: 9,
                  ),
                ),
                Observer(
                  builder: (_) => DropdownButtonFormField<String>(
                    value:
                        index_municipio_cep != null && index_municipio_cep >= 0
                            ? lista_municipios![index_municipio_cep]
                                ['municipio_codigo_ibge']
                            : campo_municipio,
                    onChanged: (newValue) {
                      setState(() {
                        campo_municipio = newValue;
                      });
                      signUpStore.municipio = newValue;
                    },
                    onTap: () => {
                      foi_tocado_municipio == false
                          ? setState(() {
                              foi_tocado_municipio = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Municipio"),
                        errorText: foi_tocado_municipio
                            ? signUpStore.validateMunicipio()
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    items: lista_municipios?.map((municipio) {
                      return DropdownMenuItem<String>(
                        value: municipio['municipio_codigo_ibge'],
                        child: Text(municipio['nome']),
                      );
                    }).toList(),
                  ),
                ),
                Text(' '),
                Observer(
                  builder: (_) => TextField(
                    controller: campo_endereco,
                    onChanged: (value) => signUpStore.endereco = value,
                    onTap: () => {
                      foi_tocado_endereco == false
                          ? setState(() {
                              foi_tocado_endereco = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Endereço"),
                        errorText: foi_tocado_endereco
                            ? signUpStore.validateEndereco()
                            : null,
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
                    onChanged: (value) => signUpStore.bairro = value,
                    onTap: () => {
                      foi_tocado_bairro == false
                          ? setState(() {
                              foi_tocado_bairro = true;
                            })
                          : '',
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text("Bairro"),
                        errorText: foi_tocado_bairro
                            ? signUpStore.validateBairro()
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
                    primary: Theme.of(context).colorScheme.inversePrimary,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: SizedBox(
                    width: double
                        .infinity, // Button expands to the full width of its parent
                    child: Center(
                      child: Text(
                        'Cadastre-se',
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
