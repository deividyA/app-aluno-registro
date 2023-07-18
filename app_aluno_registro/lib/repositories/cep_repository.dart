import 'package:app_aluno_registro/models/Cep.dart';
import 'repositories_variables.dart';
import 'package:http/http.dart';

class CepRepository {
  Future<Cep> buscarCep(String? cep) async {
    final resposta = await get(Uri.parse('$url_cep_api$cep/json/'));
    if (resposta.statusCode != 200) {
      throw Exception("Erro ao buscar os dados do Cep");
    }
    final respostaData = resposta.body;
    if (respostaData.isEmpty) {
      throw Exception("Cep Sem Informações");
    }
    return Cep.fromJson(respostaData);
  }
}
