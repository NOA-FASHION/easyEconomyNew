import 'dart:convert';
import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SaveGestionMensuelleMontantUnivUseCase {
  final SharedPreferences _localData;

  SaveGestionMensuelleMontantUnivUseCase(this._localData);

  Future<bool> execute({
    required bool remove,
    required String idGestionMensMontanUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    for (var i = listGestionMensuel.length - 1; i >= 0; i--) {
      if (listGestionMensuel[i].idGestion == idGestionMensMontanUniv) {
        if (listGestionMensuel[i].montantUniverselle.length < 1 && remove) {
          listGestionMensuel[i].montantUniverselle = [];
        }
        List<String> jsonList = listGestionMensuel.map((gestion) {
          return jsonEncode(gestion.toJson());
        }).toList();
        return _localData.setStringList(keyAcces, jsonList);
      }
    }
    return false;
  }
}
