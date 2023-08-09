// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously
import 'dart:io';
import 'package:app_aluno_registro/common.dart';
import 'package:app_aluno_registro/repositories/cep_repository.dart';
import 'package:intl/intl.dart';
import 'package:app_aluno_registro/repositories/ambiente_aluno_repository.dart';
import 'package:app_aluno_registro/stores/sign_up_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:image_picker/image_picker.dart';
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
  }

  final signUpStore = SignUpStore();
  final ImagePicker picker = ImagePicker();

  dynamic ambiente_aluno;
  List<dynamic>? lista_municipios;
  dynamic index_municipio_cep;

  Future<void> atribui_municipios() async {
    ambiente_aluno = AmbienteAlunoRepository();
    lista_municipios = await ambiente_aluno.getMunicipios();
  }

  Future<void> pickCertidaoFile(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    final XFile? result = await picker.pickImage(source: ImageSource.camera);

    if (result != null) {
      setState(() {
        certidaoFile = File(result.path);
      });
    }
  }

  Future<void> pickComprovanteResidenciaFile(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    final XFile? result = await picker.pickImage(source: ImageSource.camera);

    if (result != null) {
      setState(() {
        comprovanteResidenciaFile = File(result.path);
      });
    }
  }

  Future<void> pickFotoFile(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    final XFile? result = await picker.pickImage(source: ImageSource.camera);

    if (result != null) {
      setState(() {
        fotoFile = File(result.path);
      });
    }
  }

  Future<void> pickComprovanteMatriculaFile(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    final XFile? result = await picker.pickImage(source: ImageSource.camera);

    if (result != null) {
      setState(() {
        comprovanteMatriculaFile = File(result.path);
      });
    }
  }

  pegaDadosCep(cep) async {
    var cep_api = CepRepository();
    var cep_buscado = await cep_api.buscarCep(cep);
    // ignore: unnecessary_null_comparison
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
  File? certidaoFile;
  File? comprovanteResidenciaFile;
  File? fotoFile;
  File? comprovanteMatriculaFile;
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
  dynamic campo_municipio;
  final campo_endereco = TextEditingController();
  final campo_bairro = TextEditingController();
  final campo_cep = TextEditingController();
  bool enviar = true;

  dynamic dados_cep;
  dynamic dados;
  dynamic dados_documentos;

  getControllerValues() async {
    enviar = false;
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

      dados_documentos = {
        'numero_sere': signUpStore.numeroSere.toString(),
        'foto': fotoFile?.path,
        'certidao_nasc': certidaoFile?.path,
        'comprovante_residencia': comprovanteResidenciaFile?.path,
        'comprovante_matricula': comprovanteMatriculaFile?.path
      };

      final response = await ambiente_aluno.cadastraAluno(dados);
      final response_documentos =
          await ambiente_aluno.renovaDocumentos(dados_documentos);

      List<dynamic> errorMessages = [];

      if (response != null && response.runtimeType == String) {
        errorMessages.add(response);
      } else if (response != null) {
        response.forEach((key, value) {
          errorMessages.addAll(value);
        });
      }

      if (response_documentos != null &&
          response_documentos.runtimeType == String) {
        errorMessages.add(response_documentos);
      } else if (response_documentos != null) {
        response_documentos.forEach((key, value) {
          errorMessages.addAll(value);
        });
      }

      if (errorMessages.isNotEmpty) {
        Common.displayError(
            context, 'Erro!!', errorMessages.join(', ').toString());
      } else {
        Common.displaySuccess(
            context, 'Sucesso!!', 'Você será redirecionado', true);
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
    enviar = true;
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
          padding: const EdgeInsets.only(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Observer(builder: (_) {
                    return TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      controller: campo_numero_sere,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      onChanged: (value) => signUpStore.setNumeroSere(value),
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      labelText: "Senha",
                      errorText:
                          foi_tocado_senha ? signUpStore.validateSenha() : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
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
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: campo_cpf,
                    keyboardType: const TextInputType.numberWithOptions(
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        isDense: true,
                        label: const Text("CPF"),
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Rg"),
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Data de Nascimento"),
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
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: campo_telefone,
                    inputFormatters: [mask_telefone],
                    onChanged: (value) =>
                        signUpStore.telefone = mask_telefone.getUnmaskedText(),
                    keyboardType: const TextInputType.numberWithOptions(
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Telefone"),
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Email"),
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Sexo"),
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
                const Text(' '),
                Observer(
                  builder: (_) => TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Pai"),
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Mãe"),
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("CEP"),
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Municipio"),
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
                const Text(' '),
                Observer(
                  builder: (_) => TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Endereço"),
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
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        label: const Text("Bairro"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          pickCertidaoFile();
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.inversePrimary,
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Text('Certidao',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                    if (certidaoFile != null)
                      Image.file(
                        File(certidaoFile!.path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          pickComprovanteMatriculaFile();
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.inversePrimary,
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Text(
                          'Comprovante',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    if (comprovanteMatriculaFile != null)
                      Image.file(
                        File(comprovanteMatriculaFile!.path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          pickComprovanteResidenciaFile();
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.inversePrimary,
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Text('Residencia',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                    if (comprovanteResidenciaFile != null)
                      Image.file(
                        File(comprovanteResidenciaFile!.path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          pickFotoFile();
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.inversePrimary,
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Text('Foto',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                    if (fotoFile != null)
                      Image.file(
                        File(fotoFile!.path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: enviar == true
                      ? () {
                          getControllerValues();
                        }
                      : null,
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
                        'Cadastre-se',
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
