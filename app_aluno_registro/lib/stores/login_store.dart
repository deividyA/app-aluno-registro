import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

// ignore: library_private_types_in_public_api
class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  double? numeroSere;

  @observable
  String? senha;

  @observable
  String? token;

  @computed
  bool get isValid {
    return numeroSere != null && isNotEmpty(senha);
  }

  bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  void setNumeroSere(String value) {
    numeroSere = double.tryParse(value);
  }

  String? validateNumeroSere() {
    if (numeroSere == null) {
      return 'O campo Numero Sere é obrigatório.';
    }
    return null;
  }

  String? validateSenha() {
    if (senha == null) {
      return 'O campo senha é obrigatório.';
    }
    return null;
  }
}
