import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'remove_montant_universelle_usecase.dart';
import 'save_montant_universelle_usecase.dart';

@injectable
class EcheancePasseMontanUniveValidUseCase {
  final RemoveMontantUniverselleUseCase removeMontantUniverselleUseCase;
    final SaveMontantUniverselleUseCase saveUseCase;
  EcheancePasseMontanUniveValidUseCase(this.removeMontantUniverselleUseCase, this.saveUseCase);

  Future<void> execute({
    required int index,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    for (var i =
            listMontantUniverselle[index].descriptionUniverselle.length - 1;
        i >= 0;
        i--) {
      if (listMontantUniverselle[index].descriptionUniverselle[i].echeance >
          0) {
        listMontantUniverselle[index]
            .descriptionUniverselle[i]
            .nombreEcheance -= 1;
      }

      if (listMontantUniverselle[index]
              .descriptionUniverselle[i]
              .nombreEcheance ==
          0) {
        await removeMontantUniverselleUseCase.execute(
          index: index,
          listMontantUniverselle: listMontantUniverselle,
        );
      }
    }
    await saveUseCase.execute( listMontantUniverselle,false);
  }
}
