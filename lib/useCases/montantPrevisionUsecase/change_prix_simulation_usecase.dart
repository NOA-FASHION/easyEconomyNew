import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_montant_prevision_usecase.dart';


@injectable
class ChangePrixSimulationUseCase {
  final SaveMontantprevisionUseCase saveMontantPrevisionUseCase;

  ChangePrixSimulationUseCase(this.saveMontantPrevisionUseCase);

  Future<void> execute({
    required String montant,
    required int indexGestion,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    for (var i = listMontantPrevision.length - 1; i >= 0; i--) {
      listMontantPrevision[indexGestion].montant = double.parse(montant);
    }
    await saveMontantPrevisionUseCase.execute(listMontantPrevision);
  }
}
