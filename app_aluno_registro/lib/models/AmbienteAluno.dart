// ignore_for_file: file_names

import 'dart:convert';

class AmbienteAluno {
  String sistema;
  String municipioCodigoIbge;
  String database;

  AmbienteAluno({
    required this.sistema,
    required this.municipioCodigoIbge,
    required this.database,
  });

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sistema': sistema,
      'municipio_codigo_ibge': municipioCodigoIbge,
      'database': database,
    };
  }

  static fromJsonToList(String json) {
    final list = jsonDecode(json);
    return list;
  }

  factory AmbienteAluno.fromJsonToMap(String json) {
    final map = jsonDecode(json);
    return map;
  }

  factory AmbienteAluno.fromMap(Map<String, dynamic> map) {
    return AmbienteAluno(
      sistema: map['sistema'],
      municipioCodigoIbge: map['municipio_codigo_ibge'],
      database: map['database'],
    );
  }
}
