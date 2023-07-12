import 'package:app_aluno_registro/models/aluno.dart';
import 'package:http/http.dart';
import 'repositories_variables.dart';

class AlunoRepository {
  Future<Aluno> getAluno() async {
    final response = await get(Uri.parse('${url_bzs_api_local}aluno_usuario'));
    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar os dados do Aluno");
    }
    final responseData = response.body;
    if (responseData.isEmpty) {
      throw Exception("Aluno não encontrado");
    }
    return Aluno.fromJson(responseData);
  }
}
