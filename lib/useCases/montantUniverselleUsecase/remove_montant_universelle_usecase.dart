import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@injectable
class RemoveMontantUniverselleUseCase {
  final SaveMontantUniverselleUseCase saveMontantUniverselleUseCase;

  RemoveMontantUniverselleUseCase(this.saveMontantUniverselleUseCase);

  Future<void> execute({
    required int index,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    listMontantUniverselle.removeAt(index);
    await saveMontantUniverselleUseCase.execute(listMontantUniverselle, true);
  }
}
