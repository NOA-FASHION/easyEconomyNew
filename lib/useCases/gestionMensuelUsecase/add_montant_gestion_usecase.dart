import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:intl/intl.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddMontantGestionUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelUseCase;
  final ChoixDesciptionDetailsFinanceEnumUseCase
      choixDesciptionDetailsFinanceEnumUseCase;
  AddMontantGestionUseCase(this.saveGestionMensuelUseCase,
      this.choixDesciptionDetailsFinanceEnumUseCase);

  Future<void> execute({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    DateTime today = DateTime.now();
    for (var i = listGestionMensuel.length - 1; i >= 0; i--) {
      if (listGestionMensuel[i].mois == DateFormat('MMM').format(today)) {
        listGestionMensuel[i].montantUniverselle
          .add(
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
        await saveGestionMensuelUseCase.execute(listGestionMensuel,
            remove: false);
        return;
      }
    }
  }
}
