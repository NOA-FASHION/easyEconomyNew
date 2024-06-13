import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddMontantUniverselleUseCase {
  final ChoixDesciptionDetailsFinanceEnumUseCase
      choixDesciptionDetailsFinanceEnumUseCase;
  final AddMontantGestionUseCase addMontantGestionUseCase;
  final SaveMontantUniverselleUseCase saveMontantUniverselleUseCase;

  AddMontantUniverselleUseCase(
    this.choixDesciptionDetailsFinanceEnumUseCase,
    this.addMontantGestionUseCase,
    this.saveMontantUniverselleUseCase,
  );

  Future<void> execute({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    listMontantUniverselle.add(
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
    await saveMontantUniverselleUseCase.execute(listMontantUniverselle, false);
    return;
  }
}
