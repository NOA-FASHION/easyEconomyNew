import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'save_montant_universelle_usecase.dart';

@injectable
class ToggleActiveMontantUniverselleUseCase {
  final SaveMontantUniverselleUseCase saveMontantUniverselleUseCase;

  ToggleActiveMontantUniverselleUseCase(this.saveMontantUniverselleUseCase);

  Future<void> execute({
    required int index,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    if (listMontantUniverselle[index].previsionsTotal == 0) {
      listMontantUniverselle[index].previsionsTotal = 1;
    } else {
      listMontantUniverselle[index].previsionsTotal = 0;
    }
    await saveMontantUniverselleUseCase.execute(listMontantUniverselle,false);
  }
}
