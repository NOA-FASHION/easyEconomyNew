import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_montant_prevision_usecase.dart';


@injectable
class ToggleActiveMontantPrevisionUseCase {
  final SaveMontantprevisionUseCase saveMontantPrevisionUseCase;

  ToggleActiveMontantPrevisionUseCase(this.saveMontantPrevisionUseCase);

  Future<void> execute({
    required int index,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    if (listMontantPrevision[index].previsionsTotal == 0) {
      listMontantPrevision[index].previsionsTotal = 1;
    } else {
      listMontantPrevision[index].previsionsTotal = 0;
    }
    await saveMontantPrevisionUseCase.execute(listMontantPrevision);
  }
}
