import 'dart:convert';

import 'package:easyeconomy/mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/services/gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';

import 'package:injectable/injectable.dart';


@singleton
class ListGestionMensuelController {
 final GestionMensuelGetDataSharedpreferencies gestionMensuelGetDataSharedpreferencies;
  final MapperListGestionMensuelJsonToModelUseCase mapperListGestionMensuelJsonToModelUseCase;
  final LoadGestionMensuelUseCase loadGestionMensuelUseCase;

  final SaveGestionMensuelUseCase saveUseCase;

  List<GestionMensuel> _listGestionMensuel = [];

  ListGestionMensuelController(
    this.gestionMensuelGetDataSharedpreferencies,
    this.mapperListGestionMensuelJsonToModelUseCase,
    this.loadGestionMensuelUseCase,
    this.saveUseCase,
  );

  Future<List<GestionMensuel>> loadData() async {
    final dataList = await gestionMensuelGetDataSharedpreferencies.execute();
    if (dataList != null) {
      final jsonList = dataList
          .map((data) => jsonDecode(data))
          .toList()
          .cast<Map<String, dynamic>>();
      _listGestionMensuel = await loadGestionMensuelUseCase.execute(jsonList);
      return _listGestionMensuel;
    }
    return [];
  }

  Future<bool> saveGestionMensuelle({bool? remove}) async {
    return await saveUseCase.execute(_listGestionMensuel, remove);
  }
}
