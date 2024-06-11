import 'dart:convert';

import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/montantUniverselleServices/save_montant_universelle_sharedpreferencies.dart';

import 'package:injectable/injectable.dart';


@singleton
class SaveMontantUniverselleUseCase {
  final SaveMontantUniverselleSharedPreferencesService saveService;

  SaveMontantUniverselleUseCase(this.saveService);

  Future<bool> execute(List<MontantUniverselle> listMontantUniverselle, bool? remove) async {
    if (listMontantUniverselle.length < 1 && remove!) {
      return saveService.saveData([]);
    }
    if (listMontantUniverselle.isNotEmpty) {
      List<String> jsonList = listMontantUniverselle.map((challenge) {
        return jsonEncode(challenge.toJson());
      }).toList();
      return saveService.saveData(jsonList);
    }
    return false;
  }
}