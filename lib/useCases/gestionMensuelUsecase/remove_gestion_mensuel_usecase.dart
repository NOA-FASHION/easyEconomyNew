import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@injectable
class RemoveGestionMensuelUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelUseCase;

  RemoveGestionMensuelUseCase(this.saveGestionMensuelUseCase);

  Future<void> execute({
    required int index,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    if (index >= 0 && index < listGestionMensuel.length) {
      listGestionMensuel.removeAt(index);
      await saveGestionMensuelUseCase.execute(listGestionMensuel, remove: true);
    }
  }
}
