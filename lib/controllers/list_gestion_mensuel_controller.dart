import 'dart:convert';

import 'package:easyeconomy/mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_achat_total_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_description_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_live_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_description_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_live_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_description_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuelle_montant_univ_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/update_montant_achat_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/update_montant_prevision_usecase.dart';

import 'package:injectable/injectable.dart';

@singleton
class ListGestionMensuelController {
  final GestionMensuelGetDataSharedpreferencies
      gestionMensuelGetDataSharedpreferencies;
  final MapperListGestionMensuelJsonToModelUseCase
      mapperListGestionMensuelJsonToModelUseCase;
  final AddAchatTotalUseCase addAchatTotalUseCase;
  final UpdateMontantAchatUseCase updateMontantAchatUseCase;
  final AddGestionMensuelMontantUnivLiveUseCase
      addGestionMensuelMontantUnivLiveUseCase;
  final LoadGestionMensuelUseCase loadGestionMensuelUseCase;
  final SaveDescriptionGestionUseCase saveDescriptionGestionUseCase;
  final RemoveGestionMensuelUseCase removeGestionMensuelUseCase;
  final SaveGestionMensuelUseCase saveUseCase;
  final UpdateMontantPrevisionUseCase updateMontantPrevisionUseCase;
  final CalculateTotalAchatUseCase calculateTotalAchatUseCase;
  final AddDescriptionGestionUseCase addDescriptionGestionUseCase;
  final RemoveGestionMensuelleMontantUnivLiveUseCase
      removeGestionMensuelleMontantUnivLiveUseCase;
      final RemoveGestionDescriptionGestionUseCase removeGestionDescriptionGestionUseCase;
  final CalculateTotalPrevisionUseCase calculateTotalPrevisionUseCase;
  final RemoveGestionMensuelleMontantUnivUseCase removeGestionMensuelleMontantUnivUseCase;
  final AddMontantGestionUseCase addMontantGestionUseCase;
  final SaveGestionMensuelleMontantUnivUseCase saveGestionMensuelleMontantUnivUseCase;
  final AddGestionMensuelMontantUnivUseCase addGestionMensuelMontantUnivUseCase;
  List<GestionMensuel> _listGestionMensuel = [];

  ListGestionMensuelController(
    this.gestionMensuelGetDataSharedpreferencies,
    this.mapperListGestionMensuelJsonToModelUseCase,
    this.loadGestionMensuelUseCase,
    this.saveUseCase,
    this.addMontantGestionUseCase,
    this.removeGestionMensuelUseCase,
    this.calculateTotalPrevisionUseCase,
    this.calculateTotalAchatUseCase,
    this.updateMontantPrevisionUseCase,
    this.updateMontantAchatUseCase,
    this.addAchatTotalUseCase,
    this.addDescriptionGestionUseCase,
    this.addGestionMensuelMontantUnivUseCase,
    this.addGestionMensuelMontantUnivLiveUseCase,
    this.removeGestionMensuelleMontantUnivLiveUseCase, this.saveDescriptionGestionUseCase, this.saveGestionMensuelleMontantUnivUseCase, this.removeGestionDescriptionGestionUseCase, this.removeGestionMensuelleMontantUnivUseCase,
  );

  Future<List<GestionMensuel>> loadData() async {
    final dataList = await gestionMensuelGetDataSharedpreferencies.execute();
    if (dataList != null) {
      final jsonList = dataList
          .map((data) => jsonDecode(data))
          .toList()
          .cast<Map<String, dynamic>>();
      _listGestionMensuel = await loadGestionMensuelUseCase.execute(jsonList);
      return _listGestionMensuel;
    }
    return [];
  }

  Future<void> addMontanUniverselle({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await addMontantGestionUseCase.execute(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> removeGestionMensuelle({
    required int index,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    removeGestionMensuelUseCase.execute(
      index: index,
      listGestionMensuel: listGestionMensuel,
    );
  }

  double calculateTotalPrevision(
      int indexGestionMensuel,
      int indexGestionMensuelMontantUniv,
      List<GestionMensuel> listGestionMensuel) {
    return calculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }

  double calculateTotalAchat(
      int indexGestionMensuel,
      int indexGestionMensuelMontantUniv,
      List<GestionMensuel> listGestionMensuel) {
    return calculateTotalAchatUseCase.execute(
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> updateMontantPrevision(
      int indexGestionMensuel,
      int indexGestionMensuelMontantUniv,
      List<GestionMensuel> listGestionMensuel) async {
    await updateMontantPrevisionUseCase.execute(
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> updateMontantAchat(
      int indexGestionMensuel,
      int indexGestionMensuelMontantUniv,
      List<GestionMensuel> listGestionMensuel) async {
    await updateMontantAchatUseCase.execute(
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> addAchatTotal({
    required int indexGestion,
    required int indexGestionLive,
    required int indexGestionDescription,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await addAchatTotalUseCase.execute(
      indexGestion: indexGestion,
      indexGestionLive: indexGestionLive,
      indexGestionDescription: indexGestionDescription,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> addDescriptionGestion({
    required List<double> achat,
    required double previsions,
    required double echeance,
    required double nombreEcheance,
    required String id,
    required String adresseImage,
    required String name,
    required String commentaire,
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required String description,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await addDescriptionGestionUseCase.execute(
      achat: achat,
      previsions: previsions,
      echeance: echeance,
      nombreEcheance: nombreEcheance,
      id: id,
      adresseImage: adresseImage,
      name: name,
      commentaire: commentaire,
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
      description: description,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> addGestionMensuelMontantUniv({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required int index,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await addGestionMensuelMontantUnivUseCase.execute(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      index: index,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> addGestionMensuelMontantUnivLive({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
    required int index,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await addGestionMensuelMontantUnivLiveUseCase.execute(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      index: index,
      listGestionMensuel: listGestionMensuel,
    );
  }

  Future<void> removeGestionMensuelleMontantUnivLive({
    required bool validation,
    required int indexGestionMensuel,
    required int indexGestionMensMontanUniv,
    required String idGestionMensMontanUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await removeGestionMensuelleMontantUnivLiveUseCase.execute(
      validation: validation,
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensMontanUniv: indexGestionMensMontanUniv,
      idGestionMensMontanUniv: idGestionMensMontanUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }

   Future<bool> saveDescriptionGestion({
    required bool remove,
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    return await saveDescriptionGestionUseCase.execute(
      remove: remove,
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }
 Future<bool> saveGestionMensuelleMontantUniv({
    required bool remove,
    required String idGestionMensMontanUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    return await saveGestionMensuelleMontantUnivUseCase.execute(
      remove: remove,
      idGestionMensMontanUniv: idGestionMensMontanUniv,
      listGestionMensuel: listGestionMensuel,

    );
  }
 Future<void> removeGestionDescriptionGestion({
    required int index,
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required String idGestionMensMontanUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await removeGestionDescriptionGestionUseCase.execute(
      index: index,
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensuelMontantUniv,
      idGestionMensMontanUniv: idGestionMensMontanUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }
  Future<void> removeGestionMensuelleMontantUniv({
    required bool validation,
    required int indexGestionMensuel,
    required int indexGestionMensMontanUniv,
    required String idGestionMensMontanUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    await removeGestionMensuelleMontantUnivUseCase.execute(
      validation: validation,
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensMontanUniv: indexGestionMensMontanUniv,
      idGestionMensMontanUniv: idGestionMensMontanUniv,
      listGestionMensuel: listGestionMensuel,
    );

  }

  Future<bool> saveGestionMensuelle(
      {required List<GestionMensuel> listGestionMensuel,
      bool remove = false}) async {
    return await saveUseCase.execute(listGestionMensuel, remove: remove);
  }
}
