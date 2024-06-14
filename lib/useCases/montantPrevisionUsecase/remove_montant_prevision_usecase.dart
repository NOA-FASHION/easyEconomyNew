import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@injectable
class RemoveMontantPrevisionUseCase {
  final SaveMontantprevisionUseCase savePrevisionUseCase;

  RemoveMontantPrevisionUseCase(this.savePrevisionUseCase);

  Future<void> execute({
    required int index,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    listMontantPrevision.removeAt(index);
    await savePrevisionUseCase.execute(listMontantPrevision, remove: true);
  }
}
