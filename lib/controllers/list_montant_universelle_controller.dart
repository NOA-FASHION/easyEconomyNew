import 'dart:convert';
import 'package:easyeconomy/services/montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@singleton
class ListMontantUniverselleController {
  final MontantUniverselleGetDataSharedpreferencies getDataService;
  final LoadMontantUniverselleUseCase loadUseCase;
  final SaveMontantUniverselleUseCase saveUseCase;

  List<MontantUniverselle> _listMontantUniverselle = [];

  ListMontantUniverselleController(
    this.getDataService,
    this.loadUseCase,
    this.saveUseCase,
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

  Future<bool> saveMontantUniverselle({bool? remove}) async {
    return await saveUseCase.execute(_listMontantUniverselle, remove);
  }
}
