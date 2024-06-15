import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

@injectable
class CalculateTotalPrevisionUseCase {
  double execute({
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) {
    double totalPrev = 0;
    for (var i = listGestionMensuel[indexGestionMensuel]
                .montantUniverselle[indexGestionMensuelMontantUniv]
                .descriptionUniverselle
                .length -
            1;
        i >= 0;
        i--) {
      totalPrev += listGestionMensuel[indexGestionMensuel]
          .montantUniverselle[indexGestionMensuelMontantUniv]
          .descriptionUniverselle[i]
          .previsions;
    }
    return totalPrev;
  }
}
