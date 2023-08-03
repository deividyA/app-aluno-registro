import 'package:mobx/mobx.dart';
part 'document_renew_store.g.dart';

// ignore: library_private_types_in_public_api
class DocumentRenewStore = _DocumentRenewStore with _$DocumentRenewStore;

abstract class _DocumentRenewStore with Store {
  @observable
  double? numeroSere;

  @computed
  bool get isValid {
    return numeroSere != null;
  }

  bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  void setNumeroSere(String value) {
    numeroSere = double.tryParse(value);
  }

  String? validateNumeroSere() {
    if (numeroSere == null) {
      return 'O campo Numero Sere é obrigatório.';
    }
    return null;
  }
}
