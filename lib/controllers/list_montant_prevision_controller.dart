import 'dart:convert';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/montantPrevision/montant_prevision_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart';

import 'package:easyeconomy/useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/remove_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/reset_list_montant_prevision_usecase.dart';

import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';

import 'package:injectable/injectable.dart';

@singleton
class ListMontantPrevisionController {
  final MontantPrevisionGetDataSharedPreferences
      montantPrevisionGetDataSharedPreferences;

  final LoadMontantPrevisionUseCase loadMontantPrevisionUseCase;
  final AddMontantPrevisionUseCase addMontantPrevisionUseCase;
  final SaveMontantprevisionUseCase saveUseCase;
  final ResetListMontantPrevisionUseCase resetListMontantPrevisionUseCase;
  final RemoveMontantPrevisionUseCase removeMontantPrevisionUseCase;
  List<MontantUniverselle> _listMontantPrevision = [];

  ListMontantPrevisionController(
    this.montantPrevisionGetDataSharedPreferences,
    this.loadMontantPrevisionUseCase,
    this.saveUseCase,
    this.removeMontantPrevisionUseCase,
    this.addMontantPrevisionUseCase,
    this.resetListMontantPrevisionUseCase,
  );

  Future<List<MontantUniverselle>> loadData() async {
    final dataList = await montantPrevisionGetDataSharedPreferences.execute();
    if (dataList != null) {
      final jsonList = dataList
          .map((data) => jsonDecode(data))
          .toList()
          .cast<Map<String, dynamic>>();
      _listMontantPrevision =
          await loadMontantPrevisionUseCase.execute(jsonList);
      return _listMontantPrevision;
    }
    return [];
  }

  Future<void> removeMontantPrevision({
    required int index,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    await removeMontantPrevisionUseCase.execute(
      index: index,
      listMontantPrevision: listMontantPrevision,
    );
  }

  Future<void> addMontantPrevision({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    await addMontantPrevisionUseCase.execute(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      listMontantPrevision: listMontantPrevision,
    );
  }

  Future<void> resetListMontantPrevision(
      List<MontantUniverselle> listMontantUniverselle,
      List<MontantUniverselle> listMontantPrevision) async {
    await resetListMontantPrevisionUseCase.execute(
      listMontantUniverselle: listMontantUniverselle,
      listMontantPrevision: listMontantPrevision,
    );
  }

  Future<bool> saveMontantPrevision(
      List<MontantUniverselle> listMontantPrevision,
      {bool remove = false}) async {
    return await saveUseCase.execute(listMontantPrevision, remove: remove);
  }
}
