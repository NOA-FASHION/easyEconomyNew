import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_gestion_mensuel_usecase.dart';


@injectable
class ChangeIconsGestionMensuelUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelleUseCase;

  ChangeIconsGestionMensuelUseCase(this.saveGestionMensuelleUseCase);

  Future<void> execute({
    required int icons,
    required int indexGestionMensuel,
    required int indexGestion,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestion]
        .icones = icons;

    await saveGestionMensuelleUseCase.execute(listGestionMensuel);
  }
}
