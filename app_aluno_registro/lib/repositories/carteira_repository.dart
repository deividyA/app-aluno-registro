import 'package:app_aluno_registro/models/carteira.dart';
import 'package:http/http.dart';
import 'repositories_variables.dart';

class CarteiraRepository {
  Future<Carteira> getCarteira() async {
    final response = await get(Uri.parse('${url_bzs_api}aluno_usuario'));
    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar os dados da Carteira");
    }
    final responseData = response.body;
    if (responseData.isEmpty) {
      throw Exception("Carteira não encontrada");
    }
    return Carteira.fromJson(responseData);
  }
}
