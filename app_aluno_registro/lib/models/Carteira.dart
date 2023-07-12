import 'dart:convert';

class Carteira {
  BigInt escola_fk;
  BigInt aluno_fk;
  BigInt serie_fk;
  BigInt turno_fk;
  bool ativa;
  DateTime data_emissao;

  Carteira(
      {required BigInt this.escola_fk,
      required BigInt this.aluno_fk,
      required BigInt this.serie_fk,
      required BigInt this.turno_fk,
      required bool this.ativa,
      required DateTime this.data_emissao});

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'escola_fk': escola_fk,
      'aluno_fk': aluno_fk,
      'serie_fk': serie_fk,
      'turno_fk': turno_fk,
      'ativa': ativa,
      'data_emissao': data_emissao
    };
  }

  factory Carteira.fromJson(String json) {
    final map = jsonDecode(json);
    return Carteira.fromMap(map);
  }

  factory Carteira.fromMap(Map<String, dynamic> map) {
    return Carteira(
        escola_fk: map['escola_fk'] ?? '',
        aluno_fk: map['aluno_fk'] ?? '',
        serie_fk: map['serie_fk'] ?? '',
        turno_fk: map['turno_fk'] ?? '',
        ativa: map['ativa'] ?? '',
        data_emissao: map['data_emissao'] ?? '');
  }
}
