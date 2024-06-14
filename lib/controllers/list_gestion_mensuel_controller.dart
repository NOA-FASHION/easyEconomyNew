import 'dart:convert';

import 'package:easyeconomy/mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';

import 'package:injectable/injectable.dart';

@singleton
class ListGestionMensuelController {
  final GestionMensuelGetDataSharedpreferencies
      gestionMensuelGetDataSharedpreferencies;
  final MapperListGestionMensuelJsonToModelUseCase
      mapperListGestionMensuelJsonToModelUseCase;
  final LoadGestionMensuelUseCase loadGestionMensuelUseCase;
final RemoveGestionMensuelUseCase removeGestionMensuelUseCase;
  final SaveGestionMensuelUseCase saveUseCase;
  final AddMontantGestionUseCase addMontantGestionUseCase;
  List<GestionMensuel> _listGestionMensuel = [];

  ListGestionMensuelController(
    this.gestionMensuelGetDataSharedpreferencies,
    this.mapperListGestionMensuelJsonToModelUseCase,
    this.loadGestionMensuelUseCase,
    this.saveUseCase,
    this.addMontantGestionUseCase, this.removeGestionMensuelUseCase,
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

  Future<void> addMontanUniverselle({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await addMontantGestionUseCase.execute(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> removeGestionMensuelle({
    required int index,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    removeGestionMensuelUseCase.execute(
      index: index,
      listGestionMensuel: listGestionMensuel,
    );
    
  }

  Future<bool> saveGestionMensuelle({required List<GestionMensuel> listGestionMensuel,bool remove = false}) async {
    return await saveUseCase.execute(listGestionMensuel, remove: remove);
  }
}
