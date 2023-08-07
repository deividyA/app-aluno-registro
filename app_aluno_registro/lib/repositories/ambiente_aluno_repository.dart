import 'dart:convert';
import 'dart:io';
import 'package:app_aluno_registro/models/AmbienteAluno.dart';
import 'package:http/http.dart';
import 'repositories_variables.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  Future<dynamic> cadastraAluno(Map<String, dynamic> dados) async {
    try {
      final response = await http.post(
        Uri.parse('$url_bzs_api_local' 'ste/aluno_usuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dados),
      );
      if (response.statusCode == 200) {
        return null;
      } else if (response.statusCode != 200) {
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

  Future<dynamic> loginAluno(Map<String, dynamic> dados) async {
    try {
      final response = await http.post(
        Uri.parse('$url_bzs_api_local' 'ste/login_aluno_usuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dados),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> renovaDocumentos(Map<String, dynamic> dados) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url_bzs_api_local' 'ste/renew_documentation'),
      );

      request.fields['numero_sere'] = dados['numero_sere'];

      var fotoFile = dados['foto'];
      if (fotoFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'foto',
          fotoFile,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      var certidaoFile = dados['certidao_nasc'];
      if (certidaoFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'certidao_nasc',
          certidaoFile,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      var comprovanteResidenciaFile = dados['comprovante_residencia'];
      if (comprovanteResidenciaFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'comprovante_residencia',
          comprovanteResidenciaFile,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      var comprovanteMatriculaFile = dados['comprovante_matricula'];
      if (comprovanteMatriculaFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'comprovante_matricula',
          comprovanteMatriculaFile,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        return null;
      } else if (response.statusCode != 200) {
        var responseString = await response.stream.bytesToString();
        return jsonDecode(responseString)['message'];
      } else {
        return 'Unexpected error occurred.';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
