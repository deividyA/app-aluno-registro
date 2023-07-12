import 'dart:convert';

class Serie {
  BigInt id;
  BigInt grau_fk;
  String descricao;

  Serie({
    required this.id,
    required this.grau_fk,
    required this.descricao,
  });

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'grau_fk': grau_fk,
      'descricao': descricao,
    };
  }

  factory Serie.fromJson(String json) {
    final map = jsonDecode(json);
    return Serie.fromMap(map);
  }

  factory Serie.fromMap(Map<String, dynamic> map) {
    return Serie(
      id: map['id'] ?? BigInt.zero,
      grau_fk: map['grau_fk'] ?? BigInt.zero,
      descricao: map['descricao'] ?? '',
    );
  }
}
