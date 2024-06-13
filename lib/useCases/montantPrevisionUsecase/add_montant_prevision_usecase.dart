import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@injectable
class AddMontantPrevisionUseCase {
   final ChoixDesciptionDetailsFinanceEnumUseCase
      choixDesciptionDetailsFinanceEnumUseCase;
  final SaveMontantprevisionUseCase saveMontantprevisionUseCase;

  AddMontantPrevisionUseCase(

    this.saveMontantprevisionUseCase, this.choixDesciptionDetailsFinanceEnumUseCase,
  );

  Future<void> execute({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    listMontantPrevision.add(
      MontantUniverselle(
        unity: choixDesciptionDetailsFinanceEnumUseCase.execute(unity),
        id: id,
        montant: montant,
        nom: nom,
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: icones,
      ),
    );

    await saveMontantprevisionUseCase.execute(listMontantPrevision);
    return;
  }
}
