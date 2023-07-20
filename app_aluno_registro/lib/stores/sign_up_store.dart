import 'package:app_aluno_registro/repositories/cep_repository.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_store.g.dart';

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {
  @observable
  double? numeroSere;

  @observable
  String? nome;

  @observable
  String? cpf;

  @observable
  String? rg;

  @observable
  DateTime? dataNascimento;

  @observable
  String? telefone;

  @observable
  String? email;

  @observable
  String? sexo;

  @observable
  String? pai;

  @observable
  String? mae;

  @observable
  String? cep;

  @observable
  String? municipio;

  @observable
  String? endereco;

  @observable
  String? bairro;

  @computed
  bool get isValid {
    return numeroSere != null &&
        isNotEmpty(nome) &&
        isNotEmpty(cpf) &&
        isNotEmpty(rg) &&
        dataNascimento != null &&
        isNotEmpty(telefone) &&
        isNotEmpty(email) &&
        isNotEmpty(sexo) &&
        isNotEmpty(pai) &&
        isNotEmpty(mae) &&
        isNotEmpty(cep) &&
        isNotEmpty(municipio) &&
        isNotEmpty(endereco) &&
        isNotEmpty(bairro);
  }

  bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  void setNumeroSere(String value) {
    numeroSere = double.tryParse(value);
  }

  @action
  void setMunicipio(String? value) {
    municipio = value;
  }

  String? validateNumeroSere() {
    if (numeroSere == null) {
      return 'O campo Numero Sere é obrigatório.';
    }
    return null;
  }

  String? validateNome() {
    if (nome == null || nome!.isEmpty) {
      return 'O campo Nome é obrigatório.';
    }
    return null;
  }

  String? validateCpf() {
    if (cpf == null || cpf!.isEmpty) {
      return 'O campo CPF é obrigatório.';
    } else if (cpf!.length < 11) {
      return 'CPF precisa ter 14 caracteres';
    }
    return null;
  }

  String? validateRg() {
    if (rg == null || rg!.isEmpty) {
      return 'O campo RG é obrigatório.';
    }
    return null;
  }

  String? validateDataNascimento() {
    if (dataNascimento == null) {
      return 'O campo Data de Nascimento é obrigatório.';
    }

    return null;
  }

  String? validateTelefone() {
    if (telefone == null || telefone!.isEmpty) {
      return 'O campo Telefone é obrigatório.';
    }
    if (telefone != null) {
      print(telefone);
    }
    return null;
  }

  String? validateEmail() {
    if (email == null || email!.isEmpty) {
      return 'O campo E-mail é obrigatório.';
    }
    final emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (!emailRegExp.hasMatch(email!)) {
      return 'Utilize um E-mail válido.';
    }

    return null;
  }

  String? validateSexo() {
    if (sexo == null) {
      return 'O campo Sexo é obrigatório.';
    }
    return null;
  }

  String? validatePai() {
    if (pai == null || pai!.isEmpty) {
      return 'O campo Pai é obrigatório.';
    }
    return null;
  }

  String? validateMae() {
    if (mae == null || mae!.isEmpty) {
      return 'O campo Mãe é obrigatório.';
    }
    return null;
  }

  String? validateCep() {
    if (cep == null || cep!.isEmpty) {
      return 'O campo CEP é obrigatório.';
    }
    return null;
  }

  String? validateMunicipio() {
    if (municipio == null) {
      return 'O campo Município é obrigatório.';
    }
    return null;
  }

  String? validateEndereco() {
    if (endereco == null || endereco!.isEmpty) {
      return 'O campo Endereço é obrigatório.';
    }
    return null;
  }

  String? validateBairro() {
    if (bairro == null || bairro!.isEmpty) {
      return 'O campo Bairro é obrigatório.';
    }
    return null;
  }
}
