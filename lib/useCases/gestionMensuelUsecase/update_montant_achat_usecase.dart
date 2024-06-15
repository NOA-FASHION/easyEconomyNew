
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart';


@injectable
class UpdateMontantAchatUseCase {
  final CalculateTotalAchatUseCase calculateTotalAchatUseCase;
 final SaveGestionMensuelUseCase saveGestionMensuelUseCase;
  UpdateMontantAchatUseCase(this.calculateTotalAchatUseCase, this.saveGestionMensuelUseCase);

  Future<void>  execute({
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async{
    if (listGestionMensuel[indexGestionMensuel]
            .montantUniverselle[indexGestionMensuelMontantUniv]
            .achat
            .isNotEmpty) {
      listGestionMensuel[indexGestionMensuel]
              .montantUniverselle[indexGestionMensuelMontantUniv]
              .montant =
          calculateTotalAchatUseCase.execute(
        indexGestionMensuel: indexGestionMensuel,
        indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
        listGestionMensuel: listGestionMensuel,
      );
       await saveGestionMensuelUseCase.execute(listGestionMensuel,
            remove: false);
    }
  }
}
