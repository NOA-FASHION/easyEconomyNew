import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

@injectable
class CalculateTotalAchatUseCase {
  double execute({
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) {
    double totalAchats = 0;
    if (listGestionMensuel[indexGestionMensuel]
            .montantUniverselle[indexGestionMensuelMontantUniv]
            .achat
            .isNotEmpty) {
      for (var i = listGestionMensuel[indexGestionMensuel]
                  .montantUniverselle[indexGestionMensuelMontantUniv]
                  .achat
                  .length -
              1;
          i >= 0;
          i--) {
        totalAchats += listGestionMensuel[indexGestionMensuel]
            .montantUniverselle[indexGestionMensuelMontantUniv]
            .achat[i];
      }
    }
    return totalAchats;
  }
}
