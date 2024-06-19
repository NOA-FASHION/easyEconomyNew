import 'dart:convert';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/montantPrevision/montant_prevision_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart';

import 'package:easyeconomy/useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/remove_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/reset_list_montant_prevision_usecase.dart';

import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/toggle_active_montant_prevision_usecase.dart';

import 'package:injectable/injectable.dart';

import '../useCases/montantPrevisionUsecase/change_icons_simulation_usecase.dart';
import '../useCases/montantPrevisionUsecase/change_prix_simulation_usecase.dart';
import '../useCases/montantPrevisionUsecase/change_titre_simulation_usecase.dart';

@singleton
class ListMontantPrevisionController {
  final MontantPrevisionGetDataSharedPreferences
      montantPrevisionGetDataSharedPreferences;
final ChangeTitreSimulationUseCase changeTitreSimulationUseCase;
  final ToggleActiveMontantPrevisionUseCase toggleActiveMontantPrevisionUseCase;
final ChangeIconsSimulationUseCase changeIconsSimulationUseCase;
  final LoadMontantPrevisionUseCase loadMontantPrevisionUseCase;
  final ChangePrixSimulationUseCase changePrixSimulationUseCase;
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
    this.resetListMontantPrevisionUseCase, this.changePrixSimulationUseCase, this.changeTitreSimulationUseCase, this.changeIconsSimulationUseCase, this.toggleActiveMontantPrevisionUseCase,
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
     {required List<MontantUniverselle> listMontantUniverselle,
     required List<MontantUniverselle> listMontantPrevision} ) async {
    await resetListMontantPrevisionUseCase.execute(
      listMontantUniverselle: listMontantUniverselle,
      listMontantPrevision: listMontantPrevision,
    );
  }

   Future<void> changePrixSimulation({
    required String montant,
    required int indexGestion,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    await changePrixSimulationUseCase.execute(
      montant: montant,
      indexGestion: indexGestion,
      listMontantPrevision: listMontantPrevision,
    );
  }

    Future<void> changeTitreSimulation({
    required String nom,
    required int indexGestion,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    await changeTitreSimulationUseCase.execute(
      nom: nom,
      indexGestion: indexGestion,
      listMontantPrevision: listMontantPrevision,
    );
  }
 Future<void> changeIconsSimulation({
    required int icons,
    required int indexGestion,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    await changeIconsSimulationUseCase.execute(
      icons: icons,
      indexGestion: indexGestion,
      listMontantPrevision: listMontantPrevision,
    );
  }

   Future<void> toggleActiveMontantPrevision({
    required int index,
    required List<MontantUniverselle> listMontantPrevision,
  }) async {
    await toggleActiveMontantPrevisionUseCase.execute(
      index: index,
      listMontantPrevision: listMontantPrevision,
    );
  }
  Future<bool> saveMontantPrevision(
      List<MontantUniverselle> listMontantPrevision,
      {bool remove = false}) async {
    return await saveUseCase.execute(listMontantPrevision, remove: remove);
  }
}
