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

      // Add other form fields (non-file data) to the request
      //request.fields['numero_sere'] = dados['numero_sere'];

      request.files.add(new http.MultipartFile.fromBytes(
          'foto', await File.fromUri(Uri.parse(dados['foto'])).readAsBytes(),
          contentType: new MediaType('image', 'jpeg')));

      request.files.add(new http.MultipartFile.fromBytes('certidao_nasc',
          await File.fromUri(Uri.parse(dados['certidao_nasc'])).readAsBytes(),
          contentType: new MediaType('image', 'jpeg')));
      request.files.add(new http.MultipartFile.fromBytes(
          'comprovante_residencia',
          await File.fromUri(Uri.parse(dados['comprovante_residencia']))
              .readAsBytes(),
          contentType: new MediaType('image', 'jpeg')));
      request.files.add(new http.MultipartFile.fromBytes(
          'comprovante_matricula',
          await File.fromUri(Uri.parse(dados['comprovante_matricula']))
              .readAsBytes(),
          contentType: new MediaType('image', 'jpeg')));
      // Add the files to the request
      // if (dados['foto'] != null) {
      //   var fotoFile = dados['foto'];
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'foto',
      //     fotoFile.path,
      //     contentType:
      //         MediaType('image', 'jpeg'), // Adjust the content type accordingly
      //   ));
      // }

      // if (dados['certidao_nasc'] != null) {
      //   var certidaoFile = dados['certidao_nasc'];
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'certidao_nasc',
      //     certidaoFile.path,
      //     contentType: MediaType(
      //         'application', 'pdf'), // Adjust the content type accordingly
      //   ));
      // }

      // if (dados['comprovante_residencia'] != null) {
      //   var comprovanteResidenciaFile = dados['comprovante_residencia'];
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'comprovante_residencia',
      //     comprovanteResidenciaFile.path,
      //     contentType: MediaType(
      //         'application', 'pdf'), // Adjust the content type accordingly
      //   ));
      // }

      // if (dados['comprovante_matricula'] != null) {
      //   var comprovanteMatriculaFile = dados['comprovante_matricula'];
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'comprovante_matricula',
      //     comprovanteMatriculaFile.path,
      //     contentType: MediaType(
      //         'application', 'pdf'), // Adjust the content type accordingly
      //   ));
      // }

      var response = await request.send();

      // Read the response as a string
      var responseString = await response.stream.bytesToString();
      return jsonDecode(responseString);
    } catch (e) {
      return e.toString();
    }
  }
}
