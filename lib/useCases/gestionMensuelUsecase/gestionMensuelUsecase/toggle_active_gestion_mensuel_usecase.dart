import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import '../save_gestion_mensuel_usecase.dart';


@injectable
class ToggleActiveGestionMensuelUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelleUseCase;

  ToggleActiveGestionMensuelUseCase(this.saveGestionMensuelleUseCase);

  Future<void> execute({
    required int indexGestionMensuel,
    required int indexGestion,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    if (listGestionMensuel[indexGestionMensuel]
            .montantUniverselle[indexGestion]
            .previsionsTotal ==
        0) {
      listGestionMensuel[indexGestionMensuel]
          .montantUniverselle[indexGestion]
          .previsionsTotal = 1;
    } else {
      listGestionMensuel[indexGestionMensuel]
          .montantUniverselle[indexGestion]
          .previsionsTotal = 0;
    }
    await saveGestionMensuelleUseCase.execute(listGestionMensuel);
  }
}
