import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_gestion_mensuel_usecase.dart';


@injectable
class ChangePrixGestionMensuelUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelleUseCase;

  ChangePrixGestionMensuelUseCase(this.saveGestionMensuelleUseCase);

  Future<void> execute({
    required String montant,
    required int indexGestionMensuel,
    required int indexGestion,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestion]
        .montant = double.parse(montant);

    await saveGestionMensuelleUseCase.execute(listGestionMensuel);
  }
}
