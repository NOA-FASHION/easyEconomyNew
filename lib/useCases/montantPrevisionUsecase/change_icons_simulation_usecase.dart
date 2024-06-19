import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_montant_prevision_usecase.dart';


@injectable
class ChangeIconsSimulationUseCase {
  final SaveMontantprevisionUseCase saveMontantPrevisionUseCase;

  ChangeIconsSimulationUseCase(this.saveMontantPrevisionUseCase);

  Future<void> execute({
    required int icons,
    required int indexGestion,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    for (var i = listMontantPrevision.length - 1; i >= 0; i--) {
      listMontantPrevision[indexGestion].icones = icons;
    }
    await saveMontantPrevisionUseCase.execute(listMontantPrevision);
  }
}
