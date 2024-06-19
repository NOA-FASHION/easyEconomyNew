
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_montant_universelle_usecase.dart';


@injectable
class ChangeIconsUseCase {
  final SaveMontantUniverselleUseCase saveMontantUniverselleUseCase;

  ChangeIconsUseCase(this.saveMontantUniverselleUseCase);

  Future<void> execute({
    required int icons,
    required int indexGestion,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    for (var i = listMontantUniverselle.length - 1; i >= 0; i--) {
      listMontantUniverselle[indexGestion].icones = icons;
    }
    await saveMontantUniverselleUseCase.execute(listMontantUniverselle, false);
  }
}
