import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_gestion_mensuel_usecase.dart';


@injectable
class ChangeTitreGestionMensuelUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelleUseCase;

  ChangeTitreGestionMensuelUseCase(this.saveGestionMensuelleUseCase);

  Future<void> execute({
    required String nom,
    required int indexGestionMensuel,
    required int indexGestion,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestion]
        .nom = nom;

    await saveGestionMensuelleUseCase.execute(listGestionMensuel);
  }
}
