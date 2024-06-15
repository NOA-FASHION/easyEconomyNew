import 'dart:convert';
import 'package:easyeconomy/services/montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/add_description_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/remove_description_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/remove_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

@singleton
class ListMontantUniverselleController {
  final MontantUniverselleGetDataSharedpreferencies getDataService;
  final LoadMontantUniverselleUseCase loadUseCase;
  final SaveMontantUniverselleUseCase saveUseCase;
  final AddDescriptionMontantUniverselleUseCase
      addDescriptionUniverselleUseCase;
  final AddMontantUniverselleUseCase addMontantUniverselleUseCase;
  final RemoveMontantUniverselleUseCase removeUniverselleUseCase;
  final RemoveDescriptionMontantUniverselleUseCase
      removeDescriptionUniverselleUseCase;
  List<MontantUniverselle> _listMontantUniverselle = [];

  ListMontantUniverselleController(
    this.getDataService,
    this.loadUseCase,
    this.saveUseCase,
    this.addMontantUniverselleUseCase,
    this.removeUniverselleUseCase,
    this.addDescriptionUniverselleUseCase,
    this.removeDescriptionUniverselleUseCase,
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

  Future<void> removeMontantUniverselle({
    required int index,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    await removeUniverselleUseCase.execute(
      index: index,
      listMontantUniverselle: listMontantUniverselle,
    );
  }

  Future<void> addDescriptionMontantUniverselle({
    required List<double> achat,
    required double previsions,
    required double echeance,
    required double nombreEcheance,
    required String id,
    required String adresseImage,
    required String name,
    required String commentaire,
    required int indexChargeFixe,
    required String description,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    await addDescriptionUniverselleUseCase.execute(
      listMontantUniverselle: listMontantUniverselle,
      achat: achat,
      previsions: previsions,
      echeance: echeance,
      nombreEcheance: nombreEcheance,
      id: id,
      adresseImage: adresseImage,
      name: name,
      commentaire: commentaire,
      indexChargeFixe: indexChargeFixe,
      description: description,
    );
  }

  Future<void> removeDescriptionMontantUniverselle({
    required int index,
    required int indexChargeFixe,
    required List<MontantUniverselle> listMontantUniverselle,
  }) async {
    await removeDescriptionUniverselleUseCase.execute(
      index: index,
      indexChargeFixe: indexChargeFixe,
      listMontantUniverselle: listMontantUniverselle,
    );
  }

  Future<bool> saveMontantUniverselle(
      List<MontantUniverselle> listMontantUniverselle,
      {bool? remove}) async {
    return await saveUseCase.execute(listMontantUniverselle, remove);
  }
}
