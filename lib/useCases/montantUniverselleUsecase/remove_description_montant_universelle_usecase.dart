import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@injectable
class RemoveDescriptionMontantUniverselleUseCase {
  final SaveMontantUniverselleUseCase saveUniverselleUseCase;

  RemoveDescriptionMontantUniverselleUseCase(this.saveUniverselleUseCase);

  Future<void> execute({
    required int index,
    required int indexChargeFixe,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    listMontantUniverselle[indexChargeFixe].descriptionUniverselle.removeAt(index);
    await saveUniverselleUseCase.execute(listMontantUniverselle, true);
  }
}
