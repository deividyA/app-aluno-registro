import 'dart:convert';
import 'package:app_aluno_registro/models/AmbienteAluno.dart';
import 'package:http/http.dart';
import 'repositories_variables.dart';
import 'package:http/http.dart' as http;

class AmbienteAlunoRepository {
  Future<List> getMunicipios() async {
    final response =
        await get(Uri.parse('${url_bzs_api_local}municipios_cadastrados'));
    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar os dados dos Municipios");
    }
    final responseData = response.body;
    if (responseData.isEmpty) {
      throw Exception("Municipios Não Cadastrados");
    }

    return AmbienteAluno.fromJsonToList(responseData);
  }

  Future<dynamic?> cadastraAluno(Map<String, dynamic> dados) async {
    try {
      final response = await http.post(
        Uri.parse('$url_bzs_api_local' 'aluno_usuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dados),
      );

      if (response.statusCode == 200) {
        return null;
      } else if (response.statusCode == 422) {
        final jsonResponse = jsonDecode(response.body);
        final errorMessages = jsonResponse['message'];

        return errorMessages;
      } else if (response.statusCode == 500) {
        final jsonResponse = jsonDecode(response.body);
        final errorMessages = jsonResponse['message'];

        return errorMessages;
      } else {
        return 'Unexpected error occurred.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic?> loginAluno(Map<String, dynamic> dados) async {
    try {
      final response = await http.post(
        Uri.parse('$url_bzs_api_local' 'login_aluno_usuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dados),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        final jsonResponse = jsonDecode(response.body);

        return jsonResponse;
      } else if (response.statusCode == 500) {
        final jsonResponse = jsonDecode(response.body);

        return jsonResponse;
      } else {
        return 'Unexpected error occurred.';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
