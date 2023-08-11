import 'package:mobx/mobx.dart';

part 'forgot_password_store.g.dart';

// ignore: library_private_types_in_public_api
class ForgotPasswordStore = _ForgotPasswordStore with _$ForgotPasswordStore;

abstract class _ForgotPasswordStore with Store {
  @observable
  int? numeroSere;

  @observable
  String? email;

  @observable
  bool? enviar;

  @computed
  bool get isValid {
    return numeroSere != null && isNotEmpty(email);
  }

  bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  void setNumeroSere(String value) {
    numeroSere = int.tryParse(value);
  }

  String? validateNumeroSere() {
    if (numeroSere == null) {
      return 'O campo Numero Sere é obrigatório.';
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
}
