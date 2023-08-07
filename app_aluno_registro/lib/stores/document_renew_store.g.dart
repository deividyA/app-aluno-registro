// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_renew_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DocumentRenewStore on _DocumentRenewStore, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_DocumentRenewStore.isValid'))
      .value;

  late final _$numeroSereAtom =
      Atom(name: '_DocumentRenewStore.numeroSere', context: context);

  @override
  String? get numeroSere {
    _$numeroSereAtom.reportRead();
    return super.numeroSere;
  }

  @override
  set numeroSere(String? value) {
    _$numeroSereAtom.reportWrite(value, super.numeroSere, () {
      super.numeroSere = value;
    });
  }

  @override
  String toString() {
    return '''
numeroSere: ${numeroSere},
isValid: ${isValid}
    ''';
  }
}
