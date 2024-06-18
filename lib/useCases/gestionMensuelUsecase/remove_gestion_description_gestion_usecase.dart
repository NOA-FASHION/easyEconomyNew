import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_description_gestion_usecase.dart';


@injectable
class RemoveGestionDescriptionGestionUseCase {
  final SaveDescriptionGestionUseCase saveDescriptionGestionUseCase;

  RemoveGestionDescriptionGestionUseCase(this.saveDescriptionGestionUseCase);

  Future<void> execute({
    required int index,
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required String idGestionMensMontanUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestionMensuelMontantUniv]
        .descriptionUniverselle
        .removeAt(index);

    await saveDescriptionGestionUseCase.execute(
      remove: true,
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }
}
