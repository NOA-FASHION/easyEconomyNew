import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'echeance_no_passe_montan_unive_valid_usecase.dart';


@injectable
class EcheanceNoPasseMontanUniveUseCase {
  final EcheanceNoPasseMontanUniveValidUseCase echeanceNoPasseMontanUniveValidUseCase;

  EcheanceNoPasseMontanUniveUseCase(this.echeanceNoPasseMontanUniveValidUseCase);

  Future<void> execute({
    required String idGestionMensMontantUnv,
    required int indexGestion,
    required int indexGestionLive,
    required List<MontantUniverselle> listMontantUniverselle,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    for (var i = listMontantUniverselle.length - 1; i >= 0; i--) {
      if (listMontantUniverselle[i].id == listGestionMensuel[indexGestion]
              .montantUniverselleLive[indexGestionLive]
              .id) {
        await echeanceNoPasseMontanUniveValidUseCase.execute(
          index: i,
          listMontantUniverselle: listMontantUniverselle,
        );
      }
    }
  }
}
