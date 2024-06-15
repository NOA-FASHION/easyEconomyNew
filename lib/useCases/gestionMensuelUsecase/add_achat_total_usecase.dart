import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@injectable
class AddAchatTotalUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelUseCase;

  AddAchatTotalUseCase(this.saveGestionMensuelUseCase);

  Future<void> execute({
    required int indexGestion,
    required int indexGestionLive,
    required int indexGestionDescription,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    listGestionMensuel[indexGestion]
        .montantUniverselle[indexGestionLive]
        .achat
        .add(listGestionMensuel[indexGestion]
            .montantUniverselle[indexGestionLive]
            .descriptionUniverselle[indexGestionDescription]
            .previsions);

    await saveGestionMensuelUseCase.execute(listGestionMensuel);
  }
}
