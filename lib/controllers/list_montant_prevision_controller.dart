import 'dart:convert';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/montantPrevision/montant_prevision_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';

import 'package:injectable/injectable.dart';


@singleton
class ListMontantPrevisionController {
 final MontantPrevisionGetDataSharedPreferences montantPrevisionGetDataSharedPreferences;

  final LoadMontantPrevisionUseCase loadMontantPrevisionUseCase;

  final SaveMontantprevisionUseCase saveUseCase;

  List<MontantUniverselle> _listMontantPrevision = [];

  ListMontantPrevisionController(
    this.montantPrevisionGetDataSharedPreferences,
    this.loadMontantPrevisionUseCase,
    this.saveUseCase,
  );

  Future<List<MontantUniverselle>> loadData() async {
    final dataList = await montantPrevisionGetDataSharedPreferences.execute();
    if (dataList != null) {
      final jsonList = dataList
          .map((data) => jsonDecode(data))
          .toList()
          .cast<Map<String, dynamic>>();
      _listMontantPrevision = await loadMontantPrevisionUseCase.execute(jsonList);
      return _listMontantPrevision;
    }
    return [];
  }

  Future<bool> saveMontantPrevision({bool remove=false}) async {
    return await saveUseCase.execute(_listMontantPrevision, remove: remove);
  }
}
