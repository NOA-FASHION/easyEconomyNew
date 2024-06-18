import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

@injectable
class GenerateGestionMensuelPrevisionUseCase {
  List<MontantUniverselle> execute(List<MontantUniverselle> listMontantUniverselle) {
    List<MontantUniverselle> listMontantPrevisionGenerate = [];
    for (var i = listMontantUniverselle.length - 1; i >= 0; i--) {
      listMontantPrevisionGenerate.add(
        MontantUniverselle(
          unity: listMontantUniverselle[i].unity,
          id: listMontantUniverselle[i].id,
          montant: listMontantUniverselle[i].montant,
          nom: listMontantUniverselle[i].nom,
          descriptionUniverselle: listMontantUniverselle[i].descriptionUniverselle,
          achat: [],
          previsionsTotal: 0,
          icones: listMontantUniverselle[i].icones,
        ),
      );
    }
    return listMontantPrevisionGenerate;
  }
}
