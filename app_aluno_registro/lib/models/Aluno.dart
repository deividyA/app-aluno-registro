// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

class Aluno {
  BigInt id;
  BigInt distrito_fk;
  BigInt municipio_fk;
  String nome;
  BigInt numero_sere;
  String endereco;
  String complemento;
  String bairro;
  String cep;
  String telefone;
  String cpf;
  BigInt sexo_fk;
  String pai;
  String mae;
  DateTime data_nascimento;
  String foto;
  double latitude;
  double longitude;
  String rg;
  BigInt raca_fk;
  String localizacao;
  String responsavel_nome;
  BigInt responsavel_grau_parentesco_fk;
  String orgao_exp;

  Aluno({
    required this.id,
    required this.distrito_fk,
    required this.municipio_fk,
    required this.nome,
    required this.numero_sere,
    required this.endereco,
    required this.complemento,
    required this.bairro,
    required this.cep,
    required this.telefone,
    required this.cpf,
    required this.sexo_fk,
    required this.pai,
    required this.mae,
    required this.data_nascimento,
    required this.foto,
    required this.latitude,
    required this.longitude,
    required this.rg,
    required this.raca_fk,
    required this.localizacao,
    required this.responsavel_nome,
    required this.responsavel_grau_parentesco_fk,
    required this.orgao_exp,
  });

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'distrito_fk': distrito_fk,
      'municipio_fk': municipio_fk,
      'nome': nome,
      'numero_sere': numero_sere,
      'endereco': endereco,
      'complemento': complemento,
      'bairro': bairro,
      'cep': cep,
      'telefone': telefone,
      'cpf': cpf,
      'sexo_fk': sexo_fk,
      'pai': pai,
      'mae': mae,
      'data_nascimento': data_nascimento,
      'foto': foto,
      'latitude': latitude,
      'longitude': longitude,
      'rg': rg,
      'raca_fk': raca_fk,
      'localizacao': localizacao,
      'responsavel_nome': responsavel_nome,
      'responsavel_grau_parentesco_fk': responsavel_grau_parentesco_fk,
      'orgao_exp': orgao_exp,
    };
  }

  factory Aluno.fromJson(String json) {
    final map = jsonDecode(json);
    return Aluno.fromMap(map);
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'],
      distrito_fk: map['distrito_fk'],
      municipio_fk: map['municipio_fk'],
      nome: map['nome'],
      numero_sere: map['numero_sere'],
      endereco: map['endereco'],
      complemento: map['complemento'],
      bairro: map['bairro'],
      cep: map['cep'],
      telefone: map['telefone'],
      cpf: map['cpf'],
      sexo_fk: map['sexo_fk'],
      pai: map['pai'],
      mae: map['mae'],
      data_nascimento: map['data_nascimento'],
      foto: map['foto'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      rg: map['rg'],
      raca_fk: map['raca_fk'],
      localizacao: map['localizacao'],
      responsavel_nome: map['responsavel_nome'],
      responsavel_grau_parentesco_fk: map['responsavel_grau_parentesco_fk'],
      orgao_exp: map['orgao_exp'],
    );
  }
}
