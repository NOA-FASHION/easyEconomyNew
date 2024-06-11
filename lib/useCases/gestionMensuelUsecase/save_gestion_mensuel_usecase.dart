import 'dart:convert';

import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart';

import 'package:injectable/injectable.dart';


@singleton
class SaveGestionMensuelUseCase {
  final SaveGestionMensuelSharedPreferencesService saveService;

  SaveGestionMensuelUseCase(this.saveService);

  Future<bool> execute(List<GestionMensuel> listGestionMensuel,{bool remove = false}) async {
    if (listGestionMensuel.length < 1 && remove) {
      return saveService.saveData([]);
    }
    if (listGestionMensuel.isNotEmpty) {
      List<String> jsonList = listGestionMensuel.map((challenge) {
        return jsonEncode(challenge.toJson());
      }).toList();
      return saveService.saveData(jsonList);
    }
    return false;
  }
}