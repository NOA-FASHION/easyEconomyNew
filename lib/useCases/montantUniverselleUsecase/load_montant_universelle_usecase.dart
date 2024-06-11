import 'package:easyeconomy/mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoadMontantUniverselleUseCase {
  final MapperListGestionMensuelJsonToModelUseCase
      mapperListGestionMensuelJsonToModelUseCase;

  LoadMontantUniverselleUseCase(this.mapperListGestionMensuelJsonToModelUseCase);

  
  Future<List<MontantUniverselle>> execute(
      List<Map<String, dynamic>> jsonList) async {
    return mapperListGestionMensuelJsonToModelUseCase.execute(
        jsonList, (json) => MontantUniverselle.fromJSON(json));
  }
}
