import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

@injectable
class ChoixDesciptionUploadUseCase {
  String execute(unity_Montant_universelle json) {
    String unity = "ChargeFixe";

    if (json == unity_Montant_universelle.ChargeFixe) {
      unity = "ChargeFixe";
    } else if (json == unity_Montant_universelle.RevenuFixe) {
      unity = "RevenuFixe";
    } else if (json == unity_Montant_universelle.depensePonctuelle) {
      unity = "depensePonctuelle";
    } else if (json == unity_Montant_universelle.RevenuPonctuel) {
      unity = "RevenuPonctuel";
    }
    return unity;
  }
}
