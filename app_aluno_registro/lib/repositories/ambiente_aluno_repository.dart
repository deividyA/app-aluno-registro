import 'package:app_aluno_registro/models/AmbienteAluno.dart';
import 'package:http/http.dart';
import 'repositories_variables.dart';

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
}
