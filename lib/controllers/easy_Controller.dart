import 'dart:convert';
import 'dart:io';

import 'package:easyeconomy/controllers/list_gestion_mensuel_controller.dart';
import 'package:easyeconomy/controllers/list_montant_prevision_controller.dart';
import 'package:easyeconomy/controllers/list_montant_universelle_controller.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/choix_description_enum_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

import 'package:nanoid/nanoid.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

const String keyAcces = "gestionMensuel";
const String keyAccesMontantUniverselle = "montantUniverselle";
const String keyAccesEconomyDays = "EconomyDays";
const String keyAccesMontantPrevision = "montantPrevision";
List<GestionMensuel> _listGestionMensuel = [];
List<MontantUniverselle> _listMontantUniverselle = [];
List<MontantUniverselle> _listMontantPrevision = [];
late EconomyDays economyDays = EconomyDays(date: '');
const String keyAccesActivSwitch = "ChallengeyesterDay";

class EasyController extends ChangeNotifier {
  final ListGestionMensuelController listGestionMensuelController;
  final SharedPreferences _localData;
  final ListMontantUniverselleController listMontantUniverselleController;
  final ListMontantPrevisionController listMontantPrevisionController;
  final ChoixDesciptionDetailsFinanceEnumUseCase
      choixDesciptionDetailsFinanceEnumUseCase;
  final ChoixDesciptionEnumUseCase choixDesciptionEnumUseCase;
  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  late SharedPreferences _localDataactivSwitch;
  late double soldePrevisionel;
  late DateTime today = new DateTime.now();
  // late SharedPreferences _localData;
  // late SharedPreferences _localDataMontaUniverselle;
  late SharedPreferences _localDataEcononyDays;
  // late SharedPreferences _localDataMontantPrevision;
  late String patchData;
  late String _jsonChallengeList;
  late bool _isLoading = false;
  UploadMontantniversell uploadFileChallenge =
      UploadMontantniversell(montantUniverselle: []);
  late ActivSwitch activSwitch = ActivSwitch(
      switchIintro: '',
      date: '',
      firstActive: '',
      active: '',
      nbTacheEnCours: '',
      nbtacheVallide: '');

  EasyController(
    this.listGestionMensuelController,
    this._localData,
    this.listMontantUniverselleController,
    this.choixDesciptionDetailsFinanceEnumUseCase,
    this.choixDesciptionEnumUseCase,
    this.listMontantPrevisionController,
  ) {
    _initEconomy();
  }

  void _initEconomy() async {
    // _localData = await SharedPreferences.getInstance();
    // _localDataMontaUniverselle = await SharedPreferences.getInstance();
    // _localDataMontantPrevision = await SharedPreferences.getInstance();
    _localDataEcononyDays = await SharedPreferences.getInstance();

    // List<Map<String, dynamic>> _jsonDecodeList;
    // final List<String>? _tempList = _localData.getStringList(keyAcces);
    // if (_tempList != null) {
    //   _jsonDecodeList = _tempList
    //       .map((challengeEncoded) => jsonDecode(challengeEncoded))
    //       .toList()
    //       .cast<Map<String, dynamic>>();

    //   _listGestionMensuel = _jsonDecodeList
    //       .map((challenge) => GestionMensuel.fromJSON(challenge))
    //       .toList();
    // }

    _listGestionMensuel = await listGestionMensuelController.loadData();

    // List<Map<String, dynamic>> _jsonDecodeListMontantUniverselle;
    // final List<String>? _tempListMontantuniverselle =
    //     _localDataMontaUniverselle.getStringList(keyAccesMontantUniverselle);
    // if (_tempListMontantuniverselle != null) {
    //   _jsonDecodeListMontantUniverselle = _tempListMontantuniverselle
    //       .map((montantUniverselle) => jsonDecode(montantUniverselle))
    //       .toList()
    //       .cast<Map<String, dynamic>>();

    //   _listMontantUniverselle = _jsonDecodeListMontantUniverselle
    //       .map((challenge) => MontantUniverselle.fromJSON(challenge))
    //       .toList();
    // }
    _listMontantUniverselle = await listMontantUniverselleController.loadData();

    // List<Map<String, dynamic>> _jsonDecodeListMontantPrevision;
    // final List<String>? _tempListMontantPrevision =
    //     _localDataMontantPrevision.getStringList(keyAccesMontantPrevision);
    // if (_tempListMontantPrevision != null) {
    //   _jsonDecodeListMontantPrevision = _tempListMontantPrevision
    //       .map((montantPrevision) => jsonDecode(montantPrevision))
    //       .toList()
    //       .cast<Map<String, dynamic>>();

    //   _listMontantPrevision = _jsonDecodeListMontantPrevision
    //       .map((challenge) => MontantUniverselle.fromJSON(challenge))
    //       .toList();
    // }
    _listMontantPrevision = await listMontantPrevisionController.loadData();
    _initChallengeListStartChallenge().then((value) => startChallenyesterday());
    _initEconomyDays();
    print("_initEconomy");
    // starteconomyDays();
    notifyListeners();
  }

  List<GestionMensuel> getGestionMensuel() {
    return _listGestionMensuel;
  }

  List<MontantUniverselle> getGestionMensuelAchat(int indexGestionMensuel) {
    return _listGestionMensuel[indexGestionMensuel].montantUniverselle;
  }

  List<double> getGestionMensuelListAchat(
      int indexGestionMensuel, int indexGestionMensuelMontantUniv) {
    return _listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestionMensuelMontantUniv]
        .achat;
  }

  List<MontantUniverselle> getGestionMensuelMontantUnivLive(
      int indexGestionMensuel) {
    return _listGestionMensuel[indexGestionMensuel].montantUniverselleLive;
  }

  List<DesciprtionUniverselle> getGestionMensuelDescription(
      int indexGestionMensuel, int indexGestionMensuelMontantUniv) {
    return _listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestionMensuelMontantUniv]
        .descriptionUniverselle;
  }

  List<DesciprtionUniverselle> getMontantUnivDescription(
      int indexMontantUnvDescript) {
    return _listMontantUniverselle[indexMontantUnvDescript]
        .descriptionUniverselle;
  }

  List<MontantUniverselle> getMontantUniverselle() {
    return _listMontantUniverselle;
  }

  List<MontantUniverselle> getMontantPrevision() {
    return _listMontantPrevision;
  }

  List<MontantUniverselle> getGestionMontantUniverselle(String gestionId) {
    List<MontantUniverselle> montanUniverselle = [];
    for (var i = _listGestionMensuel.length - 1; i >= 0; i--) {
      if (_listGestionMensuel[i].idGestion == gestionId) {
        montanUniverselle = _listGestionMensuel[i].montantUniverselle;
      }
    }

    return montanUniverselle;
  }

  // unity_description choixDesciptionEnum(dynamic json) {
  //   unity_description unity = unity_description.tache;

  //   if (json == "tache") {
  //     unity = unity_description.tache;
  //     return unity;
  //   } else if (json == "commentaire") {
  //     unity = unity_description.commentaire;
  //     return unity;
  //   } else if (json == "image") {
  //     unity = unity_description.image;
  //     return unity;
  //   } else if (json == "achat") {
  //     unity = unity_description.achat;
  //     return unity;
  //   } else if (json == "echeancier") {
  //     unity = unity_description.echeancier;
  //     return unity;
  //   } else if (json == "information") {
  //     unity = unity_description.information;
  //     return unity;
  //   }
  //   return unity;
  // }

  // addDescriptionMontaUniv(
  //     {required List<double> achat,
  //     required double previsions,
  //     required double echeance,
  //     required double nombreEcheance,
  //     required String id,
  //     required String adresseImage,
  //     required String name,
  //     required String commentaire,
  //     required int indexChargeFixe,
  //     required String description}) async {
  //   _listMontantUniverselle[indexChargeFixe].descriptionUniverselle.add(
  //       DesciprtionUniverselle(
  //           adresseImage: adresseImage,
  //           commentaire: commentaire,
  //           description: choixDesciptionEnumUseCase.execute(description),
  //           echeance: echeance,
  //           id: id,
  //           name: name,
  //           previsions: previsions,
  //           nombreEcheance: nombreEcheance));
  //   await listMontantPrevisionController.saveMontantPrevision(
  //     _listMontantUniverselle,
  //   );
  //   _initEconomy();
  //   notifyListeners();
  //   return;
  // }

  Future<void> addDescriptionMontaUniv({
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
  }) async {
    try {
      await listMontantUniverselleController.addDescriptionMontantUniverselle(
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
        listMontantUniverselle: _listMontantUniverselle,
      );

      // _initEconomy();
      notifyListeners();
      return;
    } catch (e) {
      print('Error in addDescriptionMontantUniverselle: $e');
    }
  }

  // void removeDescriptionMontaUniv({
  //   required int index,
  //   required int indexChargeFixe,
  // }) async {
  //   _listMontantUniverselle[indexChargeFixe]
  //       .descriptionUniverselle
  //       .removeAt(index);

  //   await _saveDescriptionMontaUniv(
  //     remove: true,
  //     indexChargeFixe: indexChargeFixe,
  //     index: index,
  //   );
  //   _initEconomy();
  //   notifyListeners();
  // }

  Future<void> removeDescriptionMontaUniv({
    required int index,
    required int indexChargeFixe,
  }) async {
    try {
      await listMontantUniverselleController
          .removeDescriptionMontantUniverselle(
        index: index,
        indexChargeFixe: indexChargeFixe,
        listMontantUniverselle: _listMontantUniverselle,
      );

      _initEconomy();
      notifyListeners();
    } catch (e) {
      print('Error in removeDescriptionMontantUniverselle: $e');
    }
  }

  // Future<bool> _saveDescriptionMontaUniv(
  //     {required bool remove,
  //     required int indexChargeFixe,
  //     required int index}) async {
  //   if (_listMontantUniverselle[indexChargeFixe].descriptionUniverselle.length <
  //           1 &&
  //       remove) {
  //     _listMontantUniverselle[indexChargeFixe].descriptionUniverselle = [];
  //   }
  //   List<String> _jsonList = _listMontantUniverselle.map((challenge) {
  //     return jsonEncode(challenge.toJson());
  //   }).toList();
  //   return _localData.setStringList(keyAccesMontantUniverselle, _jsonList);
  // }

  // double totalPrevision(
  //     int indexGestionMensuel, int indexGestionMensuelMontantUniv) {
  //   double totalPrev = 0;
  //   for (var i = _listGestionMensuel[indexGestionMensuel]
  //               .montantUniverselle[indexGestionMensuelMontantUniv]
  //               .descriptionUniverselle
  //               .length -
  //           1;
  //       i >= 0;
  //       i--) {
  //     totalPrev = totalPrev +
  //         _listGestionMensuel[indexGestionMensuel]
  //             .montantUniverselle[indexGestionMensuelMontantUniv]
  //             .descriptionUniverselle[i]
  //             .previsions;
  //   }
  //   return totalPrev;
  // }

  // double totalAchat(
  //     int indexGestionMensuel, int indexGestionMensuelMontantUniv) {
  //   double totalAchats = 0;
  //   if (_listGestionMensuel[indexGestionMensuel]
  //           .montantUniverselle[indexGestionMensuelMontantUniv]
  //           .achat
  //           .length >
  //       0) {
  //     for (var i = _listGestionMensuel[indexGestionMensuel]
  //                 .montantUniverselle[indexGestionMensuelMontantUniv]
  //                 .achat
  //                 .length -
  //             1;
  //         i >= 0;
  //         i--) {
  //       totalAchats = totalAchats +
  //           _listGestionMensuel[indexGestionMensuel]
  //               .montantUniverselle[indexGestionMensuelMontantUniv]
  //               .achat[i];
  //     }
  //   }
  //   return totalAchats;
  // }

  // montantPrevision(
  //     int indexGestionMensuel, int indexGestionMensuelMontantUniv) {
  //   for (var i = _listGestionMensuel[indexGestionMensuel]
  //               .montantUniverselle[indexGestionMensuelMontantUniv]
  //               .descriptionUniverselle
  //               .length -
  //           1;
  //       i >= 0;
  //       i--) {
  //     if (_listGestionMensuel[indexGestionMensuel]
  //                 .montantUniverselle[indexGestionMensuelMontantUniv]
  //                 .descriptionUniverselle[i]
  //                 .previsions >
  //             0 &&
  //         _listGestionMensuel[indexGestionMensuel]
  //                 .montantUniverselle[indexGestionMensuelMontantUniv]
  //                 .achat
  //                 .length <=
  //             0) {
  //       _listGestionMensuel[indexGestionMensuel]
  //               .montantUniverselle[indexGestionMensuelMontantUniv]
  //               .montant =
  //           listGestionMensuelController.calculateTotalPrevision(indexGestionMensuel, indexGestionMensuelMontantUniv, _listGestionMensuel);
  //       return;
  //     }
  //   }
  // }

  // montantAchat(int indexGestionMensuel, int indexGestionMensuelMontantUniv) {
  //   if (_listGestionMensuel[indexGestionMensuel]
  //           .montantUniverselle[indexGestionMensuelMontantUniv]
  //           .achat
  //           .length >
  //       0) {
  //     _listGestionMensuel[indexGestionMensuel]
  //             .montantUniverselle[indexGestionMensuelMontantUniv]
  //             .montant =
  //         listGestionMensuelController.calculateTotalAchat(indexGestionMensuel, indexGestionMensuelMontantUniv, _listGestionMensuel);
  //   }
  // }

  achatTotals(String idGestionMensMontantUnv, int indexGestion,
      int indexGestionLive, int indexgestiondescription) async {
    // _listGestionMensuel[indexGestion]
    //     .montantUniverselle[indexGestionLive]
    //     .achat
    //     .add(_listGestionMensuel[indexGestion]
    //         .montantUniverselle[indexGestionLive]
    //         .descriptionUniverselle[indexgestiondescription]
    //         .previsions);
    await listGestionMensuelController.addAchatTotal(
      indexGestion: indexGestion,
      indexGestionLive: indexGestionLive,
      indexGestionDescription: indexgestiondescription,
      listGestionMensuel: _listGestionMensuel,
    );
    await listGestionMensuelController.updateMontantAchat(
        indexGestion, indexGestionLive, _listGestionMensuel);
    // await listGestionMensuelController.saveGestionMensuelle(
    //     listGestionMensuel: _listGestionMensuel);
    // _initEconomy();
    notifyListeners();
  }

  addDescriptionGestion(
      {required List<double> achat,
      required double previsions,
      required double echeance,
      required double nombreEcheance,
      required String id,
      required String adresseImage,
      required String name,
      required String commentaire,
      required int indexGestionMensuel,
      required int indexGestionMensuelMontantUniv,
      required String description}) async {
    await listGestionMensuelController.addDescriptionGestion(
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
        listGestionMensuel: _listGestionMensuel);

    listGestionMensuelController.updateMontantPrevision(indexGestionMensuel,
        indexGestionMensuelMontantUniv, _listGestionMensuel);
    // await listGestionMensuelController.saveGestionMensuelle(
    //     listGestionMensuel: _listGestionMensuel);
    // _initEconomyDays();
    notifyListeners();
    return;
  }

  List<MontantUniverselle> getGestionMontantUniverselleLive(String gestionId) {
    List<MontantUniverselle> montanUniverselle = [];
    for (var i = _listGestionMensuel.length - 1; i >= 0; i--) {
      if (_listGestionMensuel[i].idGestion == gestionId) {
        montanUniverselle = _listGestionMensuel[i].montantUniverselleLive;
      }
    }

    return montanUniverselle;
  }

  List<MontantUniverselle> getIndexGestionMontantUniverselleLive(
      int indexGestion) {
    return _listGestionMensuel[indexGestion].montantUniverselleLive;
  }

  List<MontantUniverselle> getIndexGestionMontantUniverselle(int indexGestion) {
    return _listGestionMensuel[indexGestion].montantUniverselle;
  }

  void removeMontantUniverselle({
    required int index,
  }) async {
    try {
      await listMontantUniverselleController.removeMontantUniverselle(
        index: index,
        listMontantUniverselle: _listMontantUniverselle,
      );

      notifyListeners();
    } catch (e) {
      print('Error in removeMontantUniverselle: $e');
    }
    // _initEconomy();
    notifyListeners();
  }

  void resetListMontantPrevision() async {
    _listMontantPrevision = [];
    for (var i = _listMontantUniverselle.length - 1; i >= 0; i--) {
      _listMontantPrevision.add(
        MontantUniverselle(
            unity: _listMontantUniverselle[i].unity,
            id: _listMontantUniverselle[i].id,
            montant: _listMontantUniverselle[i].montant,
            nom: _listMontantUniverselle[i].nom,
            descriptionUniverselle:
                _listMontantUniverselle[i].descriptionUniverselle,
            achat: [],
            previsionsTotal: 0,
            icones: _listMontantUniverselle[i].icones),
      );
    }
    await listMontantPrevisionController
        .saveMontantPrevision(_listMontantPrevision, remove: true);
    _initEconomy();
    notifyListeners();
  }

  // Future<bool> _saveMontantUniverselle({bool remove = false}) async {
  //   if (_listMontantUniverselle.length < 1 && remove!) {
  //     return _localData.setStringList(keyAccesMontantUniverselle, []);
  //   }
  //   if (_listMontantUniverselle.isNotEmpty) {
  //     List<String> _jsonList = _listMontantUniverselle.map((challenge) {
  //       return jsonEncode(challenge.toJson());
  //     }).toList();
  //     return _localData.setStringList(keyAccesMontantUniverselle, _jsonList);
  //   }

  //   return false;
  // }

  int idmontantUniverselle(int index) {
    int index2 = 0;
    for (var i = _listMontantPrevision.length - 1; i >= 0; i--) {
      if (_listMontantUniverselle[index].id == _listMontantPrevision[i].id) {
        index2 = i;
      }
    }
    return index2;
  }

  // void removeMontantPrevision({
  //   required int index,
  // }) async {
  //   // await removeChallengelistId(index);
  //   _listMontantPrevision.removeAt(index);
  //   await saveMontantprevisionUseCase.execute(_listMontantPrevision,
  //       remove: true);
  //   _initEconomy();
  //   notifyListeners();
  // }

  Future<void> removeMontantPrevision({
    required int index,
  }) async {
    try {
      await listMontantPrevisionController.removeMontantPrevision(
        index: index,
        listMontantPrevision: _listMontantPrevision,
      );

      notifyListeners();
    } catch (e) {
      print('Error in removeMontantPrevision: $e');
    }
  }

  // Future<bool> _saveMontantPrevision({bool? remove}) async {
  //   if (_listMontantPrevision.length < 1 && remove!) {
  //     return _localData
  //         .setStringList(keyAccesMontantPrevision, []);
  //   }
  //   if (_listMontantPrevision.isNotEmpty) {
  //     List<String> _jsonList = _listMontantPrevision.map((challenge) {
  //       return jsonEncode(challenge.toJson());
  //     }).toList();
  //     return _localData.setStringList(
  //         keyAccesMontantPrevision, _jsonList);
  //   }

  //   return false;
  // }

  // unity_Montant_universelle choixDesciptionEnum1(dynamic json) {
  //   unity_Montant_universelle unity = unity_Montant_universelle.ChargeFixe;

  //   if (json == "ChargeFixe") {
  //     unity = unity_Montant_universelle.ChargeFixe;
  //     return unity;
  //   } else if (json == "RevenuFixe") {
  //     unity = unity_Montant_universelle.RevenuFixe;
  //     return unity;
  //   } else if (json == "depensePonctuelle") {
  //     unity = unity_Montant_universelle.depensePonctuelle;
  //     return unity;
  //   } else if (json == "RevenuPonctuel") {
  //     unity = unity_Montant_universelle.RevenuPonctuel;
  //     return unity;
  //   }
  //   return unity;
  // }

  // void addMontanUniverselle({
  //   required int icones,
  //   required String nom,
  //   required double montant,
  //   required String id,
  //   required String unity,
  // }) async {
  //   _listMontantUniverselle.add(
  //     MontantUniverselle(
  //         unity: choixDesciptionDetailsFinanceEnumUseCase.execute(unity),
  //         id: id,
  //         montant: montant,
  //         nom: nom,
  //         descriptionUniverselle: [],
  //         achat: [],
  //         previsionsTotal: 0,
  //         icones: icones),
  //   );
  //   addMontantPrevision(
  //       id: id, montant: montant, nom: nom, unity: unity, icones: icones);
  //   addMontantGestionUseCase.execute(
  //     icones: icones,
  //     nom: nom,
  //     montant: montant,
  //     id: id,
  //     unity: unity,
  //     listGestionMensuel: _listGestionMensuel,
  //   );
  //   _initEconomyDays();
  //   await _saveMontantUniverselle();
  //   _initEconomy();
  //   notifyListeners();
  // }

  void addMontanUniverselle({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
  }) async {
    await listMontantUniverselleController.addMontanUniverselle(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      listMontantUniverselle: _listMontantUniverselle,
    );
    await listMontantPrevisionController.addMontantPrevision(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      listMontantPrevision: _listMontantPrevision,
    );
    await listGestionMensuelController.addMontanUniverselle(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      listGestionMensuel: _listGestionMensuel,
    );

    // _initEconomyDays();
    // _initEconomy();
    notifyListeners();
  }

  // void addMontantGestion({
  //   required int icones,
  //   required String nom,
  //   required double montant,
  //   required String id,
  //   required String unity,
  // }) async {
  //   DateTime today = new DateTime.now();
  //   for (var i = _listGestionMensuel.length - 1; i >= 0; i--) {
  //     if (_listGestionMensuel[i].mois == DateFormat('MMM').format(today)) {
  //       _listGestionMensuel[i].montantUniverselle
  //         ..add(
  //           MontantUniverselle(
  //               unity: choixDesciptionEnum1(unity),
  //               id: id,
  //               montant: montant,
  //               nom: nom,
  //               descriptionUniverselle: [],
  //               achat: [],
  //               previsionsTotal: 0,
  //               icones: icones),
  //         );
  //       // await _saveGestionMensuelle();
  //       await listGestionMensuelController.saveGestionMensuelle();
  //       _initEconomyDays();
  //       notifyListeners();
  //       return;
  //     }
  //   }
  // }
  // Future<void> addMontantGestion({
  //   required int icones,
  //   required String nom,
  //   required double montant,
  //   required String id,
  //   required String unity,
  // }) async {
  //   await addMontantGestionUseCase.execute(
  //     icones: icones,
  //     nom: nom,
  //     montant: montant,
  //     id: id,
  //     unity: unity,
  //     listGestionMensuel: _listGestionMensuel,
  //   );
  //   _initEconomyDays();
  //   notifyListeners();
  // }

  // void addMontantPrevision({
  //   required int icones,
  //   required String nom,
  //   required double montant,
  //   required String id,
  //   required String unity,
  // }) async {
  //   _listMontantPrevision.add(
  //     MontantUniverselle(
  //         unity: choixDesciptionDetailsFinanceEnumUseCase.execute(unity),
  //         id: id,
  //         montant: montant,
  //         nom: nom,
  //         descriptionUniverselle: [],
  //         achat: [],
  //         previsionsTotal: 0,
  //         icones: icones),
  //   );

  //   await saveMontantprevisionUseCase.execute(_listMontantPrevision);
  //   _initEconomy();
  //   notifyListeners();
  // }

  void addMontantPrevision({
    required int icones,
    required String nom,
    required double montant,
    required String id,
    required String unity,
  }) async {
    await listMontantPrevisionController.addMontantPrevision(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      listMontantPrevision: _listMontantPrevision,
    );
    // _initEconomy();
    notifyListeners();
  }

  void starteconomyDays() async {
    // print('economydays:' + economyDays.date);
    DateTime today = new DateTime.now();
    String todays = DateFormat('MMM').format(today);
    if (economyDays.date.isEmpty || economyDays.date != todays) {
      print('create gestionMensuel');
      economyDays.date = todays;
      _listGestionMensuel.add(
        GestionMensuel(
            idGestion: nanoid(10),
            mois: DateFormat('MMM').format(today),
            montantUniverselle: _ListGestionMensuelPrevision(),
            nom: 'Mois en cours',
            tendance: '',
            montantUniverselleLive: []),
      );

      // await _saveGestionMensuelle();
      await listGestionMensuelController.saveGestionMensuelle(
          listGestionMensuel: _listGestionMensuel);
      await _saveEconomyDays();
      // _initEconomyDays();
      // notifyListeners();
    }
    // creatListGestionMensuel();
  }

  Future<bool> _saveEconomyDays() async {
    if (economyDays.date.isNotEmpty) {
      // print("enregistrement ok");
      Map mapday = economyDays.toJson();
      String _jsonDay = jsonEncode(mapday);
      return _localDataEcononyDays.setString(keyAccesEconomyDays, _jsonDay);
    }

    return false;
  }

  void _initEconomyDays() async {
    // print('init econodays');
    _localDataEcononyDays = await SharedPreferences.getInstance();
    Map<String, dynamic> _jsonDecodeEconomyDays;
    final String? _tempListChallenge =
        _localDataEcononyDays.getString(keyAccesEconomyDays);

    if (_tempListChallenge != null) {
      // print('economy:' + economyDays.date);
      _jsonDecodeEconomyDays = jsonDecode(_tempListChallenge);
      economyDays = EconomyDays.fromJSON(_jsonDecodeEconomyDays);
    }
    starteconomyDays();
  }

  void addGestionMensuelMontantUniv(
      {required int icones,
      required String nom,
      required double montant,
      required String id,
      required String unity,
      required int index}) async {
    _listGestionMensuel[index].montantUniverselle.add(MontantUniverselle(
        unity: choixDesciptionDetailsFinanceEnumUseCase.execute(unity),
        id: id,
        montant: montant,
        nom: nom,
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: icones));
    // await _saveGestionMensuelle();
    await listGestionMensuelController.saveGestionMensuelle(
        listGestionMensuel: _listGestionMensuel);
    _initEconomyDays();
    notifyListeners();
  }

  void addGestionMensuelMontantUnivLive(
      {required int icones,
      required String nom,
      required double montant,
      required String id,
      required String unity,
      required int index}) async {
    _listGestionMensuel[index].montantUniverselleLive.add(MontantUniverselle(
        unity: choixDesciptionDetailsFinanceEnumUseCase.execute(unity),
        id: id,
        montant: montant,
        nom: nom,
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: icones));
    // await _saveGestionMensuelle();
    await listGestionMensuelController.saveGestionMensuelle(
        listGestionMensuel: _listGestionMensuel);
    _initEconomyDays();
    notifyListeners();
  }

  List<MontantUniverselle> _ListGestionMensuelPrevision() {
    List<MontantUniverselle> listMontantPrevision1 = [];
    for (var i = _listMontantUniverselle.length - 1; i >= 0; i--) {
      listMontantPrevision1.add(
        MontantUniverselle(
            unity: _listMontantUniverselle[i].unity,
            id: _listMontantUniverselle[i].id,
            montant: _listMontantUniverselle[i].montant,
            nom: _listMontantUniverselle[i].nom,
            descriptionUniverselle:
                _listMontantUniverselle[i].descriptionUniverselle,
            achat: [],
            previsionsTotal: 0,
            icones: _listMontantUniverselle[i].icones),
      );
    }
    return listMontantPrevision1;
  }

  // void creatListGestionMensuel() async {
  //   DateTime today = new DateTime.now();
  //   String todays = DateFormat('MMM').format(today);
  //   if (economyDays.date != todays) {
  //     // print('date != econonydays');
  //     economyDays.date = DateFormat('MMM').format(today);
  //     _listGestionMensuel.add(
  //       GestionMensuel(
  //           idGestion: nanoid(10),
  //           mois: DateFormat('MMM').format(today),
  //           montantUniverselle: _ListGestionMensuelPrevision(),
  //           nom: 'Mois en cours',
  //           tendance: '',
  //           montantUniverselleLive: []),
  //     );
  //     await _saveEconomyDays();
  //     // await _saveGestionMensuelle();
  //     await listGestionMensuelController.saveGestionMensuelle(localData: _localData);
  //     // _initEconomyDays();
  //     // notifyListeners();
  //   }
  // }

  Future<void> removeGestionMensuelle({
    required int index,
  }) async {
    listGestionMensuelController.removeGestionMensuelle(
      index: index,
      listGestionMensuel: _listGestionMensuel,
    );
    // _initEconomy();
    notifyListeners();
  }

  // void removeGestionMensuelle({
  //   required int index,
  // }) async {
  //   // await removeChallengelistId(index);
  //   _listGestionMensuel.removeAt(index);
  //   // await _saveGestionMensuelle(remove: true);
  //   await listGestionMensuelController.saveGestionMensuelle(remove: true);
  //   _initEconomy();
  //   notifyListeners();
  // }

  void removeGestionMensuelleMontantUnivLive(
      {required bool validation,
      required int indexGestionMensuel,
      required int indexGestionMensMontanUniv,
      required String idGestionMensMontanUniv}) async {
    if (validation) {
      _listGestionMensuel[indexGestionMensuel].montantUniverselle.add(
            MontantUniverselle(
                unity: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .unity,
                id: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .id,
                montant: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .montant,
                nom: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .nom,
                descriptionUniverselle: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .descriptionUniverselle,
                achat: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .achat,
                previsionsTotal: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .previsionsTotal,
                icones: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .icones),
          );
    }

    _listGestionMensuel[indexGestionMensuel]
        .montantUniverselleLive
        .removeAt(indexGestionMensMontanUniv);

    await _saveGestionMensuelleMontantUniv(
        remove: true, idGestionMensMontanUniv: idGestionMensMontanUniv);
    _initEconomy();
    notifyListeners();
  }

  void removeGestionDescriptionGestion(
      {required int index,
      required int indexGestionMensuel,
      required int indexGestionMensMontanUniv,
      required String idGestionMensMontanUniv}) async {
    _listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestionMensMontanUniv]
        .descriptionUniverselle
        .removeAt(index);

    await _saveDescriptionGestion(
      remove: true,
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensMontanUniv,
    );
    _initEconomy();
    notifyListeners();
  }

  Future<bool> _saveDescriptionGestion(
      {required bool remove,
      required int indexGestionMensuel,
      required int indexGestionMensuelMontantUniv}) async {
    if (_listGestionMensuel[indexGestionMensuel]
                .montantUniverselle[indexGestionMensuelMontantUniv]
                .descriptionUniverselle
                .length <
            1 &&
        remove) {
      _listGestionMensuel[indexGestionMensuel]
          .montantUniverselle[indexGestionMensuelMontantUniv]
          .descriptionUniverselle = [];
    }
    List<String> _jsonList = _listGestionMensuel.map((gestion) {
      return jsonEncode(gestion.toJson());
    }).toList();
    return _localData.setStringList(keyAcces, _jsonList);
  }

  void removeGestionMensuelleMontantUniv(
      {required bool validation,
      required int indexGestionMensuel,
      required int indexGestionMensMontanUniv,
      required String idGestionMensMontanUniv}) async {
    if (validation) {
      _listGestionMensuel[indexGestionMensuel].montantUniverselleLive.add(
            MontantUniverselle(
                unity: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .unity,
                id: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .id,
                montant: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .montant,
                nom: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .nom,
                descriptionUniverselle: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .descriptionUniverselle,
                achat: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .achat,
                previsionsTotal: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .previsionsTotal,
                icones: _listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .icones),
          );
    }

    _listGestionMensuel[indexGestionMensuel]
        .montantUniverselle
        .removeAt(indexGestionMensMontanUniv);

    await _saveGestionMensuelleMontantUniv(
        remove: true, idGestionMensMontanUniv: idGestionMensMontanUniv);
    _initEconomy();
    notifyListeners();
  }

  Future<bool> _saveGestionMensuelleMontantUniv(
      {required bool remove, required String idGestionMensMontanUniv}) async {
    for (var i = _listGestionMensuel.length - 1; i >= 0; i--) {
      if (_listGestionMensuel[i].idGestion == idGestionMensMontanUniv) {
        if (_listGestionMensuel[i].montantUniverselle.length < 1 && remove) {
          _listGestionMensuel[i].montantUniverselle = [];
        }
        List<String> _jsonList = _listGestionMensuel.map((gestion) {
          return jsonEncode(gestion.toJson());
        }).toList();
        return _localData.setStringList(keyAcces, _jsonList);
      }
    }
    return false;
  }

  // Future<bool> _saveGestionMensuelle({bool? remove}) async {
  //   if (_listGestionMensuel.length < 1 && remove!) {
  //     return _localData.setStringList(keyAcces, []);
  //   }
  //   if (_listGestionMensuel.isNotEmpty) {
  //     List<String> _jsonList = _listGestionMensuel.map((challenge) {
  //       return jsonEncode(challenge.toJson());
  //     }).toList();
  //     return _localData.setStringList(keyAcces, _jsonList);
  //   }

  //   return false;
  // }

  deleteNombreEcheance() {}

  echeancePasseMontanUniveValid(int index) {
    for (var i =
            _listMontantUniverselle[index].descriptionUniverselle.length - 1;
        i >= 0;
        i--) {
      if (_listMontantUniverselle[index].descriptionUniverselle[i].echeance >
          0) {
        // print("montant echeance ok");
        _listMontantUniverselle[index]
            .descriptionUniverselle[i]
            .nombreEcheance = _listMontantUniverselle[index]
                .descriptionUniverselle[i]
                .nombreEcheance -
            1;
      }

      if (_listMontantUniverselle[index]
              .descriptionUniverselle[i]
              .nombreEcheance ==
          0) {
        // print("montant echeance ok");
        removeMontantUniverselle(index: index);
      }
    }
  }

  echeancePasseMontanUnive(String idGestionMensMontantUnv, int indexGestion,
      int indexGestionLive) async {
    for (var i = _listMontantUniverselle.length - 1; i >= 0; i--) {
      if (_listMontantUniverselle[i].id ==
          _listGestionMensuel[indexGestion]
              .montantUniverselle[indexGestionLive]
              .id) {
        echeancePasseMontanUniveValid(i);
      }
    }
    await listMontantPrevisionController.saveMontantPrevision(
      _listMontantUniverselle,
    );
    _initEconomy();
    notifyListeners();
  }

  echeanceNoPasseMontanUniveValid(int index) {
    for (var i =
            _listMontantUniverselle[index].descriptionUniverselle.length - 1;
        i >= 0;
        i--) {
      if (_listMontantUniverselle[index].descriptionUniverselle[i].echeance >
          0) {
        _listMontantUniverselle[index]
            .descriptionUniverselle[i]
            .nombreEcheance = _listMontantUniverselle[index]
                .descriptionUniverselle[i]
                .nombreEcheance +
            1;
      }
    }
  }

  echeanceNoPasseMontanUnive(String idGestionMensMontantUnv, int indexGestion,
      int indexGestionLive) async {
    for (var i = _listMontantUniverselle.length - 1; i >= 0; i--) {
      if (_listMontantUniverselle[i].id ==
          _listGestionMensuel[indexGestion]
              .montantUniverselleLive[indexGestionLive]
              .id) {
        echeanceNoPasseMontanUniveValid(i);
      }
    }
    await listMontantPrevisionController.saveMontantPrevision(
      _listMontantUniverselle,
    );
    _initEconomy();
    notifyListeners();
  }

  void changePrix({
    required String montant,
    required int indexGestion,
  }) async {
    for (var i = _listMontantUniverselle.length - 1; i >= 0; i--) {
      _listMontantUniverselle[indexGestion].montant = double.parse(montant);
    }
    await listMontantPrevisionController.saveMontantPrevision(
      _listMontantUniverselle,
    );
    _initEconomy();
    notifyListeners();
  }

  void changeTitre({
    required String nom,
    required int indexGestion,
  }) async {
    for (var i = _listMontantUniverselle.length - 1; i >= 0; i--) {
      _listMontantUniverselle[indexGestion].nom = nom;
    }
    await listMontantPrevisionController.saveMontantPrevision(
      _listMontantUniverselle,
    );
    _initEconomy();
    notifyListeners();
  }

  void changeIcons({
    required int icons,
    required int indexGestion,
  }) async {
    for (var i = _listMontantUniverselle.length - 1; i >= 0; i--) {
      _listMontantUniverselle[indexGestion].icones = icons;
    }
    await listMontantPrevisionController.saveMontantPrevision(
      _listMontantUniverselle,
    );
    _initEconomy();
    notifyListeners();
  }

  void changePrixSimulation({
    required String montant,
    required int indexGestion,
  }) async {
    for (var i = _listMontantPrevision.length - 1; i >= 0; i--) {
      _listMontantPrevision[indexGestion].montant = double.parse(montant);
    }
    await await listMontantPrevisionController
        .saveMontantPrevision(_listMontantPrevision);
    _initEconomy();
    notifyListeners();
  }

  void changeTitreSimulation({
    required String nom,
    required int indexGestion,
  }) async {
    for (var i = _listMontantPrevision.length - 1; i >= 0; i--) {
      _listMontantPrevision[indexGestion].nom = nom;
    }
    await await listMontantPrevisionController
        .saveMontantPrevision(_listMontantPrevision);
    _initEconomy();
    notifyListeners();
  }

  void changeIconsSimulation({
    required int icons,
    required int indexGestion,
  }) async {
    for (var i = _listMontantPrevision.length - 1; i >= 0; i--) {
      _listMontantPrevision[indexGestion].icones = icons;
    }
    await await listMontantPrevisionController
        .saveMontantPrevision(_listMontantPrevision);
    _initEconomy();
    notifyListeners();
  }

  void changePrixGestionMensuel({
    required String montant,
    required int indexGestionMensuel,
    required int indexGestion,
  }) async {
    _listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestion]
        .montant = double.parse(montant);

    // await _saveGestionMensuelle();
    await listGestionMensuelController.saveGestionMensuelle(
        listGestionMensuel: _listGestionMensuel);
    _initEconomy();
    notifyListeners();
  }

  void changeTitreGestionMensuel({
    required String nom,
    required int indexGestionMensuel,
    required int indexGestion,
  }) async {
    // print(_listGestionMensuel[indexGestionMensuel]
    // .montantUniverselle
    // .length
    // .toString());
    _listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestion]
        .nom = nom;

    // await _saveGestionMensuelle();
    await listGestionMensuelController.saveGestionMensuelle(
        listGestionMensuel: _listGestionMensuel);
    _initEconomy();
    notifyListeners();
  }

  void changeIconsGestionMensuel({
    required int icons,
    required int indexGestionMensuel,
    required int indexGestion,
  }) async {
    _listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestion]
        .icones = icons;

    // await _saveGestionMensuelle();
    await listGestionMensuelController.saveGestionMensuelle(
        listGestionMensuel: _listGestionMensuel);
    _initEconomy();
    notifyListeners();
  }

  activeListListMontantUniverselle({required int index}) async {
    if (_listMontantUniverselle[index].previsionsTotal == 0) {
      _listMontantUniverselle[index].previsionsTotal = 1;
    } else {
      _listMontantUniverselle[index].previsionsTotal = 0;
    }
    await listMontantPrevisionController.saveMontantPrevision(
      _listMontantUniverselle,
    );
    _initEconomy();
    notifyListeners();
  }

  activeListListMontantPrevision({required int index}) async {
    if (_listMontantPrevision[index].previsionsTotal == 0) {
      _listMontantPrevision[index].previsionsTotal = 1;
    } else {
      _listMontantPrevision[index].previsionsTotal = 0;
    }
    await listMontantPrevisionController
        .saveMontantPrevision(_listMontantPrevision);
    _initEconomy();
    notifyListeners();
  }

  activeListListGestionMensuel(
      {required int indexGestionMensuel, required int indexGestion}) async {
    if (_listGestionMensuel[indexGestionMensuel]
            .montantUniverselle[indexGestion]
            .previsionsTotal ==
        0) {
      _listGestionMensuel[indexGestionMensuel]
          .montantUniverselle[indexGestion]
          .previsionsTotal = 1;
    } else {
      _listGestionMensuel[indexGestionMensuel]
          .montantUniverselle[indexGestion]
          .previsionsTotal = 0;
    }
    // await _saveGestionMensuelle();
    await listGestionMensuelController.saveGestionMensuelle(
        listGestionMensuel: _listGestionMensuel);
    _initEconomy();
    notifyListeners();
  }

  Future<String> readContent() async {
    String contents = "";
    try {
      final path = await FlutterDocumentPicker.openDocument();
      final file = File(path!);
      contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'Error!';
    }
  }

  void uploadChallenge() async {
    UploadMontantniversell uploadFileChallenge =
        UploadMontantniversell(montantUniverselle: []);
    Map<String, dynamic> _jsonDecodeuploadFile;
    String uploadFile = await readContent();
    if (uploadFile.isNotEmpty) {
      _jsonDecodeuploadFile = jsonDecode(uploadFile);
      uploadFileChallenge =
          UploadMontantniversell.fromJSON(_jsonDecodeuploadFile);

      for (var i = uploadFileChallenge.montantUniverselle.length - 1;
          i >= 0;
          i--) {
        addMontanUniverselle(
            id: uploadFileChallenge.montantUniverselle[i].id,
            montant: uploadFileChallenge.montantUniverselle[i].montant,
            nom: uploadFileChallenge.montantUniverselle[i].nom,
            unity: choixDesciptionEnum2(
                uploadFileChallenge.montantUniverselle[i].unity),
            icones: uploadFileChallenge.montantUniverselle[i].icones);
      }
    }
  }

  String choixDesciptionEnum2(unity_Montant_universelle json) {
    String unity = "ChargeFixe";

    if (json == unity_Montant_universelle.ChargeFixe) {
      unity = "ChargeFixe";
      return unity;
    } else if (json == unity_Montant_universelle.RevenuFixe) {
      unity = "RevenuFixe";
      return unity;
    } else if (json == unity_Montant_universelle.depensePonctuelle) {
      unity = "depensePonctuelle";
      return unity;
    } else if (json == unity_Montant_universelle.RevenuPonctuel) {
      unity = "RevenuPonctuel";
      return unity;
    }
    return unity;
  }

  void addMontanUniverselleUpload() async {
    // uploadFileChallenge.montantUniverselle = _listMontantUniverselle;
    // await delay(1500);
    for (var i = _listMontantUniverselle.length - 1; i >= 0; i--) {
      uploadFileChallenge.montantUniverselle.add(
        MontantUniverselle(
            unity: _listMontantUniverselle[i].unity,
            id: _listMontantUniverselle[i].id,
            montant: _listMontantUniverselle[i].montant,
            nom: _listMontantUniverselle[i].nom,
            descriptionUniverselle:
                _listMontantUniverselle[i].descriptionUniverselle,
            achat: _listMontantUniverselle[i].achat,
            previsionsTotal: _listMontantUniverselle[i].previsionsTotal,
            icones: _listMontantUniverselle[i].icones),
      );
    }
  }

  void writeContent() async {
    final file = await _localFile;
    // Write the file
    addMontanUniverselleUpload();

    await file.writeAsString(_saveLocalData());
    Share.shareXFiles([XFile(file.path)], text: "Challenges");
  }

  String _saveLocalData() {
    Map<String, dynamic>? mapChallengeList = uploadFileChallenge.toJson();
    _jsonChallengeList = jsonEncode(mapChallengeList);
    return _jsonChallengeList;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    patchData = '$path/challengeList.txt';
    return File('$path/challengeList.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  ActivSwitch getChallengeyesterday() {
    return activSwitch;
  }

  Future<bool> _saveChallenyesterday() async {
    Map mapyesterday = activSwitch.toJson();
    String _jsonyesterday = jsonEncode(mapyesterday);
    return _localData.setString(keyAccesActivSwitch, _jsonyesterday);

    return false;
  }

  void switchTrueIntro(bool active) async {
    if (active) {
      activSwitch.active = "true";
    } else {
      activSwitch.active = "false";
    }

    await _saveChallenyesterday();
    // _initChallengeListStartChallenge();
  }

  void initChallengeyesterday() async {
    // getBoolActivation();
    // await modifDtabaseFirebase();
    DateTime today = new DateTime.now();
    DateTime lastDay =
        DateFormat('EEEE, d MMM, yyyy').parseStrict(activSwitch.date);

    if ((today.day >= (lastDay.day + 1)) && (today.month > lastDay.month)) {
      if (activSwitch.firstActive == "true") {
        activSwitch.firstActive = "false";
        activSwitch.active = "false";
        // print("initChallengeyesterday");
        await _saveChallenyesterday();
        _initChallengeListStartChallenge();
      }
    }
  }

  void startChallenyesterday() async {
    DateTime today = new DateTime.now();
    if (activSwitch.nbTacheEnCours!.isEmpty) {
      // print('start challenge yestederday');
      activSwitch.date = DateFormat('EEEE, d MMM, yyyy').format(today);
      activSwitch.firstActive = "true";
      activSwitch.nbTacheEnCours = "false";
      activSwitch.switchIintro = "true";
      activSwitch.active = "true";
      activSwitch.nbtacheVallide = "";
      // await initialiseConnectionDatabase();
      // print("startChallenyesterday");
      await _saveChallenyesterday();
      _initChallengeListStartChallenge();
    }
    initChallengeyesterday();
  }

  Future<void> _initChallengeListStartChallenge() async {
    _localDataactivSwitch = await SharedPreferences.getInstance();
    Map<String, dynamic> _jsonDecodeListActivSwitch;
    final String? _tempListActivSwitch =
        _localDataactivSwitch.getString(keyAccesActivSwitch);
    if (_tempListActivSwitch != null) {
      _jsonDecodeListActivSwitch = jsonDecode(_tempListActivSwitch);
      activSwitch = ActivSwitch.fromJSON(_jsonDecodeListActivSwitch);
    }
    // print("_initChallengeListStartChallenge");
    // startChallenyesterday();
    // initChallengeyesterday();

    // notifyListeners();
  }

  switchIntro(String switchBoll) async {
    if (switchBoll == "true" || switchBoll == "") {
      activSwitch.switchIintro = "false";
    } else {
      activSwitch.switchIintro = "true";
    }
    await _saveChallenyesterday();
    _initChallengeListStartChallenge();
  }

  isLoadingTrue() {
    _isLoading = true;
    _initEconomy();
    notifyListeners();
  }

  isLoadingFalse() {
    _isLoading = false;
    _initEconomy();
    notifyListeners();
  }

  bool boolIsloading() {
    return _isLoading;
  }
}
