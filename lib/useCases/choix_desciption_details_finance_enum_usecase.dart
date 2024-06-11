import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChoixDesciptionDetailsFinanceEnumUseCase {
  unity_Montant_universelle execute(dynamic json) {
    unity_Montant_universelle unity = unity_Montant_universelle.ChargeFixe;

    if (json == "ChargeFixe") {
      unity = unity_Montant_universelle.ChargeFixe;
    } else if (json == "RevenuFixe") {
      unity = unity_Montant_universelle.RevenuFixe;
    } else if (json == "depensePonctuelle") {
      unity = unity_Montant_universelle.depensePonctuelle;
    } else if (json == "RevenuPonctuel") {
      unity = unity_Montant_universelle.RevenuPonctuel;
    }

    return unity;
  }
}
