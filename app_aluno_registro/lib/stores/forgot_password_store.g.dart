// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotPasswordStore on _ForgotPasswordStore, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_ForgotPasswordStore.isValid'))
      .value;

  late final _$numeroSereAtom =
      Atom(name: '_ForgotPasswordStore.numeroSere', context: context);

  @override
  int? get numeroSere {
    _$numeroSereAtom.reportRead();
    return super.numeroSere;
  }

  @override
  set numeroSere(int? value) {
    _$numeroSereAtom.reportWrite(value, super.numeroSere, () {
      super.numeroSere = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_ForgotPasswordStore.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  @override
  String toString() {
    return '''
numeroSere: ${numeroSere},
email: ${email},
isValid: ${isValid}
    ''';
  }
}
