import 'dart:convert';
import 'package:http/http.dart' as http;
import 'repositories_variables.dart';

class AlunoRepository {
  // ignore: non_constant_identifier_names
  Future<List> getAlunos(String token, int numero_sere) async {
    final response = await http.get(
      Uri.parse('${url_bzs_api}carteira_completa/$numero_sere'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar os dados do Aluno");
    }
    final responseData = response.body;
    if (responseData.isEmpty) {
      throw Exception("Aluno não encontrado");
    }

    return jsonDecode(responseData);
  }
}
