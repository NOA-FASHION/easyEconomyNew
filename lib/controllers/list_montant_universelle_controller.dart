import 'dart:convert';
import 'package:easyeconomy/services/montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/remove_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@singleton
class ListMontantUniverselleController {
  final MontantUniverselleGetDataSharedpreferencies getDataService;
  final LoadMontantUniverselleUseCase loadUseCase;
  final SaveMontantUniverselleUseCase saveUseCase;
 final AddMontantUniverselleUseCase addMontantUniverselleUseCase;
 final RemoveMontantUniverselleUseCase removeUniverselleUseCase;
  List<MontantUniverselle> _listMontantUniverselle = [];

  ListMontantUniverselleController(
    this.getDataService,
    this.loadUseCase,
    this.saveUseCase, this.addMontantUniverselleUseCase, this.removeUniverselleUseCase,
  );

  Future<List<MontantUniverselle>> loadData() async {
    final dataList = await getDataService.execute();
    if (dataList != null) {
      final jsonList = dataList
          .map((data) => jsonDecode(data))
          .toList()
          .cast<Map<String, dynamic>>();
      _listMontantUniverselle = await loadUseCase.execute(jsonList);
      return _listMontantUniverselle;
    }
    return [];
  }

  Future<void> addMontanUniverselle({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    await addMontantUniverselleUseCase.execute(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      listMontantUniverselle: listMontantUniverselle,
    );
  }

     Future<void>  removeMontantUniverselle({
    required int index,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    await removeUniverselleUseCase.execute(
      index: index,
      listMontantUniverselle: listMontantUniverselle,
     
    );
  }

  Future<bool> saveMontantUniverselle(List<MontantUniverselle> listMontantUniverselle,{bool? remove}) async {
    return await saveUseCase.execute(listMontantUniverselle, remove);
  }
}
