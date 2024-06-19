
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_montant_universelle_usecase.dart';


@injectable
class ChangeTitreUseCase {
final SaveMontantUniverselleUseCase saveMontantUniverselleUseCase;

  ChangeTitreUseCase(this.saveMontantUniverselleUseCase);

  Future<void> execute({
    required String nom,
    required int indexGestion,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    for (var i = listMontantUniverselle.length - 1; i >= 0; i--) {
      listMontantUniverselle[indexGestion].nom = nom;
    }
    await saveMontantUniverselleUseCase.execute(listMontantUniverselle, false);
  }
}
