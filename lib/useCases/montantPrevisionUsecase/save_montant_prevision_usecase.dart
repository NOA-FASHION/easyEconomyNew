import 'dart:convert';

import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/montantPrevision/save_montant_prevision_sharedpreferencies.dart';

import 'package:injectable/injectable.dart';


@singleton
class SaveMontantprevisionUseCase {
  final SaveMontantPrevisionSharedPreferencesService saveService;

  SaveMontantprevisionUseCase(this.saveService);

  Future<bool> execute(List<MontantUniverselle> listMontantPrevision, {bool remove = false}) async {
    if (listMontantPrevision.length < 1 && remove!) {
      return saveService.saveData([]);
    }
    if (listMontantPrevision.isNotEmpty) {
      List<String> jsonList = listMontantPrevision.map((challenge) {
        return jsonEncode(challenge.toJson());
      }).toList();
      return saveService.saveData(jsonList);
    }
    return false;
  }
}