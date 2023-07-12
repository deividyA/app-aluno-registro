import 'package:app_aluno_registro/models/serie.dart';
import 'package:http/http.dart';
import 'repositories_variables.dart';

class SerieRepository {
  Future<Serie> getSerie() async {
    final response = await get(Uri.parse('${url_bzs_api_local}serie_usuario'));
    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar os dados da Série");
    }
    final responseData = response.body;
    if (responseData.isEmpty) {
      throw Exception("Série não encontrada");
    }
    return Serie.fromJson(responseData);
  }
}
