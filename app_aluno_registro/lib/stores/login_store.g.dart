// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: '_LoginStore.isValid'))
      .value;

  late final _$numeroSereAtom =
      Atom(name: '_LoginStore.numeroSere', context: context);

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

  late final _$senhaAtom = Atom(name: '_LoginStore.senha', context: context);

  @override
  String? get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String? value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  @override
  String toString() {
    return '''
numeroSere: ${numeroSere},
senha: ${senha},
isValid: ${isValid}
    ''';
  }
}
