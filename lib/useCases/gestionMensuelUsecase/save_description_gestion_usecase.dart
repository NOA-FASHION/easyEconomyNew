import 'dart:convert';
import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SaveDescriptionGestionUseCase {
  final SharedPreferences _localData;

  SaveDescriptionGestionUseCase(this._localData);

  Future<bool> execute({
    required bool remove,
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required List<GestionMensuel> listGestionMensuel,

  }) async {
    if (listGestionMensuel[indexGestionMensuel]
                .montantUniverselle[indexGestionMensuelMontantUniv]
                .descriptionUniverselle
                .length <
            1 &&
        remove) {
      listGestionMensuel[indexGestionMensuel]
          .montantUniverselle[indexGestionMensuelMontantUniv]
          .descriptionUniverselle = [];
    }
    List<String> jsonList = listGestionMensuel.map((gestion) {
      return jsonEncode(gestion.toJson());
    }).toList();
    return _localData.setStringList(keyAcces, jsonList);
  }
}
