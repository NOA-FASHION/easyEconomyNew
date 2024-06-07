import 'package:easyeconomy/mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoadGestionMensuelUseCase {
  final MapperListGestionMensuelJsonToModelUseCase
      mapperListGestionMensuelJsonToModelUseCase;

  LoadGestionMensuelUseCase(this.mapperListGestionMensuelJsonToModelUseCase);

  
  Future<List<GestionMensuel>> execute(
      List<Map<String, dynamic>> jsonList) async {
    return mapperListGestionMensuelJsonToModelUseCase.execute(
        jsonList, (json) => GestionMensuel.fromJSON(json));
  }
}
