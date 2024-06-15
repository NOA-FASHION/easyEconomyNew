
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart';


@injectable
class UpdateMontantPrevisionUseCase {
  final CalculateTotalPrevisionUseCase calculateTotalPrevisionUseCase;
 final SaveGestionMensuelUseCase saveGestionMensuelUseCase;
  UpdateMontantPrevisionUseCase(this.calculateTotalPrevisionUseCase, this.saveGestionMensuelUseCase);

   Future<void> execute({
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required List<GestionMensuel> listGestionMensuel,
  })async {
    for (var i = listGestionMensuel[indexGestionMensuel]
                .montantUniverselle[indexGestionMensuelMontantUniv]
                .descriptionUniverselle
                .length -
            1;
        i >= 0;
        i--) {
      if (listGestionMensuel[indexGestionMensuel]
                  .montantUniverselle[indexGestionMensuelMontantUniv]
                  .descriptionUniverselle[i]
                  .previsions >
              0 &&
          listGestionMensuel[indexGestionMensuel]
                  .montantUniverselle[indexGestionMensuelMontantUniv]
                  .achat
                  .isEmpty) {
        listGestionMensuel[indexGestionMensuel]
                .montantUniverselle[indexGestionMensuelMontantUniv]
                .montant =
            calculateTotalPrevisionUseCase.execute(
              indexGestionMensuel: indexGestionMensuel,
              indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
              listGestionMensuel: listGestionMensuel,
            );
             await saveGestionMensuelUseCase.execute(listGestionMensuel,
            remove: false);
        return;
      }
    }
  }
}
