// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpStore on _SignUpStore, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: '_SignUpStore.isValid'))
      .value;

  late final _$numeroSereAtom =
      Atom(name: '_SignUpStore.numeroSere', context: context);

  @override
  double? get numeroSere {
    _$numeroSereAtom.reportRead();
    return super.numeroSere;
  }

  @override
  set numeroSere(double? value) {
    _$numeroSereAtom.reportWrite(value, super.numeroSere, () {
      super.numeroSere = value;
    });
  }

  late final _$nomeAtom = Atom(name: '_SignUpStore.nome', context: context);

  @override
  String? get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String? value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$cpfAtom = Atom(name: '_SignUpStore.cpf', context: context);

  @override
  String? get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String? value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  late final _$rgAtom = Atom(name: '_SignUpStore.rg', context: context);

  @override
  String? get rg {
    _$rgAtom.reportRead();
    return super.rg;
  }

  @override
  set rg(String? value) {
    _$rgAtom.reportWrite(value, super.rg, () {
      super.rg = value;
    });
  }

  late final _$dataNascimentoAtom =
      Atom(name: '_SignUpStore.dataNascimento', context: context);

  @override
  String? get dataNascimento {
    _$dataNascimentoAtom.reportRead();
    return super.dataNascimento;
  }

  @override
  set dataNascimento(String? value) {
    _$dataNascimentoAtom.reportWrite(value, super.dataNascimento, () {
      super.dataNascimento = value;
    });
  }

  late final _$telefoneAtom =
      Atom(name: '_SignUpStore.telefone', context: context);

  @override
  String? get telefone {
    _$telefoneAtom.reportRead();
    return super.telefone;
  }

  @override
  set telefone(String? value) {
    _$telefoneAtom.reportWrite(value, super.telefone, () {
      super.telefone = value;
    });
  }

  late final _$emailAtom = Atom(name: '_SignUpStore.email', context: context);

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

  late final _$sexoAtom = Atom(name: '_SignUpStore.sexo', context: context);

  @override
  String? get sexo {
    _$sexoAtom.reportRead();
    return super.sexo;
  }

  @override
  set sexo(String? value) {
    _$sexoAtom.reportWrite(value, super.sexo, () {
      super.sexo = value;
    });
  }

  late final _$paiAtom = Atom(name: '_SignUpStore.pai', context: context);

  @override
  String? get pai {
    _$paiAtom.reportRead();
    return super.pai;
  }

  @override
  set pai(String? value) {
    _$paiAtom.reportWrite(value, super.pai, () {
      super.pai = value;
    });
  }

  late final _$maeAtom = Atom(name: '_SignUpStore.mae', context: context);

  @override
  String? get mae {
    _$maeAtom.reportRead();
    return super.mae;
  }

  @override
  set mae(String? value) {
    _$maeAtom.reportWrite(value, super.mae, () {
      super.mae = value;
    });
  }

  late final _$cepAtom = Atom(name: '_SignUpStore.cep', context: context);

  @override
  String? get cep {
    _$cepAtom.reportRead();
    return super.cep;
  }

  @override
  set cep(String? value) {
    _$cepAtom.reportWrite(value, super.cep, () {
      super.cep = value;
    });
  }

  late final _$municipioAtom =
      Atom(name: '_SignUpStore.municipio', context: context);

  @override
  String? get municipio {
    _$municipioAtom.reportRead();
    return super.municipio;
  }

  @override
  set municipio(String? value) {
    _$municipioAtom.reportWrite(value, super.municipio, () {
      super.municipio = value;
    });
  }

  late final _$enderecoAtom =
      Atom(name: '_SignUpStore.endereco', context: context);

  @override
  String? get endereco {
    _$enderecoAtom.reportRead();
    return super.endereco;
  }

  @override
  set endereco(String? value) {
    _$enderecoAtom.reportWrite(value, super.endereco, () {
      super.endereco = value;
    });
  }

  late final _$bairroAtom = Atom(name: '_SignUpStore.bairro', context: context);

  @override
  String? get bairro {
    _$bairroAtom.reportRead();
    return super.bairro;
  }

  @override
  set bairro(String? value) {
    _$bairroAtom.reportWrite(value, super.bairro, () {
      super.bairro = value;
    });
  }

  late final _$senhaAtom = Atom(name: '_SignUpStore.senha', context: context);

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

  late final _$_SignUpStoreActionController =
      ActionController(name: '_SignUpStore', context: context);

  @override
  void setMunicipio(String? value) {
    final _$actionInfo = _$_SignUpStoreActionController.startAction(
        name: '_SignUpStore.setMunicipio');
    try {
      return super.setMunicipio(value);
    } finally {
      _$_SignUpStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
numeroSere: ${numeroSere},
nome: ${nome},
cpf: ${cpf},
rg: ${rg},
dataNascimento: ${dataNascimento},
telefone: ${telefone},
email: ${email},
sexo: ${sexo},
pai: ${pai},
mae: ${mae},
cep: ${cep},
municipio: ${municipio},
endereco: ${endereco},
bairro: ${bairro},
senha: ${senha},
isValid: ${isValid}
    ''';
  }
}
