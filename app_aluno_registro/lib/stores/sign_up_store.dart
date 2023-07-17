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
        nome != null &&
        cpf != null &&
        rg != null &&
        dataNascimento != null &&
        telefone != null &&
        email != null &&
        sexo != null &&
        pai != null &&
        mae != null &&
        cep != null &&
        municipio != null &&
        endereco != null &&
        bairro != null;
  }

  void setNumeroSere(String value) {
    numeroSere = double.tryParse(value);
    print(numeroSere);
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

  String? validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo Nome é obrigatório.';
    }
    return null;
  }

  String? validateCpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo CPF é obrigatório.';
    }
    return null;
  }

  String? validateRg(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo RG é obrigatório.';
    }
    return null;
  }

  String? validateDataNascimento(DateTime? value) {
    if (value == null) {
      return 'O campo Data de Nascimento é obrigatório.';
    }
    return null;
  }

  String? validateTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo Telefone é obrigatório.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo E-mail é obrigatório.';
    }
    return null;
  }

  String? validateSexo(String? value) {
    if (value == null) {
      return 'O campo Sexo é obrigatório.';
    }
    return null;
  }

  String? validatePai(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo Pai é obrigatório.';
    }
    return null;
  }

  String? validateMae(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo Mãe é obrigatório.';
    }
    return null;
  }

  String? validateCep(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo CEP é obrigatório.';
    }
    return null;
  }

  String? validateMunicipio(String? value) {
    if (value == null) {
      return 'O campo Município é obrigatório.';
    }
    return null;
  }

  String? validateEndereco(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo Endereço é obrigatório.';
    }
    return null;
  }

  String? validateBairro(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo Bairro é obrigatório.';
    }
    return null;
  }
}
