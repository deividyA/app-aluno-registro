import 'package:mobx/mobx.dart';
part 'document_renew_store.g.dart';

// ignore: library_private_types_in_public_api
class DocumentRenewStore = _DocumentRenewStore with _$DocumentRenewStore;

abstract class _DocumentRenewStore with Store {
  @observable
  String? numeroSere;

  @computed
  bool get isValid {
    return isNotEmpty(numeroSere);
  }

  bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  String? validateNumeroSere() {
    if (numeroSere == null) {
      return 'O campo Numero Sere é obrigatório.';
    }
    return null;
  }
}
