import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_gestion_mensuel_usecase.dart';

@injectable
class AddGestionMensuelMontantUnivUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelUseCase;
  final ChoixDesciptionDetailsFinanceEnumUseCase choixDesciptionDetailsFinanceEnumUseCase;

  AddGestionMensuelMontantUnivUseCase(
    this.saveGestionMensuelUseCase,
    this.choixDesciptionDetailsFinanceEnumUseCase,
  );

  Future<void> execute({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required int index,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    listGestionMensuel[index].montantUniverselle.add(MontantUniverselle(
        unity: choixDesciptionDetailsFinanceEnumUseCase.execute(unity),
        id: id,
        montant: montant,
        nom: nom,
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: icones));
    await saveGestionMensuelUseCase.execute(listGestionMensuel, remove: false);
  }
}
