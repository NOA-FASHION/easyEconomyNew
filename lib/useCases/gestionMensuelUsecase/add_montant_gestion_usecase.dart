import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:intl/intl.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@singleton
class AddMontantGestionUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelUseCase;

  AddMontantGestionUseCase(this.saveGestionMensuelUseCase);

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
        listGestionMensuel[i].montantUniverselle.add(
          MontantUniverselle(
            unity: choixDesciptionEnum1(unity),
            id: id,
            montant: montant,
            nom: nom,
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: icones,
          ),
        );
        await saveGestionMensuelUseCase.execute(listGestionMensuel, false);
        return;
      }
    }
  }
}
