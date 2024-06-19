import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_montant_universelle_usecase.dart';



@injectable
class EcheanceNoPasseMontanUniveValidUseCase {
  final SaveMontantUniverselleUseCase saveUseCase;
  EcheanceNoPasseMontanUniveValidUseCase(this.saveUseCase);
  Future<void> execute({
    required int index,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    for (var i = listMontantUniverselle[index].descriptionUniverselle.length - 1; i >= 0; i--) {
      if (listMontantUniverselle[index].descriptionUniverselle[i].echeance > 0) {
        listMontantUniverselle[index].descriptionUniverselle[i].nombreEcheance += 1;
      }
    }
        await saveUseCase.execute( listMontantUniverselle, false);
  }
}
