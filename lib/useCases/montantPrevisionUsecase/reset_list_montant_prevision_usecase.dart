
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_montant_prevision_usecase.dart';


@injectable
class ResetListMontantPrevisionUseCase {
  final SaveMontantprevisionUseCase saveMontantPrevisionUseCase;

  ResetListMontantPrevisionUseCase(this.saveMontantPrevisionUseCase);

  Future<void> execute({
    required List<MontantUniverselle> listMontantUniverselle,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    listMontantPrevision.clear();
    for (var i = listMontantUniverselle.length - 1; i >= 0; i--) {
      listMontantPrevision.add(
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
    await saveMontantPrevisionUseCase.execute(listMontantPrevision, remove: true);
  }
}
