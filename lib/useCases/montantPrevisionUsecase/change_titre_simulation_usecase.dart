import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_montant_prevision_usecase.dart';


@injectable
class ChangeTitreSimulationUseCase {
  final SaveMontantprevisionUseCase saveMontantPrevisionUseCase;

  ChangeTitreSimulationUseCase(this.saveMontantPrevisionUseCase);

  Future<void> execute({
    required String nom,
    required int indexGestion,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    for (var i = listMontantPrevision.length - 1; i >= 0; i--) {
      listMontantPrevision[indexGestion].nom = nom;
    }
    await saveMontantPrevisionUseCase.execute(listMontantPrevision);
  }
}
