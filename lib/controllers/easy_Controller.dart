import 'dart:convert';
import 'dart:io';

import 'package:easyeconomy/controllers/list_gestion_mensuel_controller.dart';
import 'package:easyeconomy/controllers/list_montant_prevision_controller.dart';
import 'package:easyeconomy/controllers/list_montant_universelle_controller.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/choix_desciption_upload_usecase.dart';
import 'package:easyeconomy/useCases/choix_description_enum_usecase.dart';
import 'package:easyeconomy/useCases/generate_gestion_mensuel_prevision_usecase.dart';
import 'package:easyeconomy/useCases/read_content_usecase.dart';
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
  final ReadContentUseCase readContentUseCase;
  final ListMontantUniverselleController listMontantUniverselleController;
  final ListMontantPrevisionController listMontantPrevisionController;
  final ChoixDesciptionUploadUseCase choixDesciptionUploadUseCase;
  final GenerateGestionMensuelPrevisionUseCase
      generateGestionMensuelPrevisionUseCase;

  final ChoixDesciptionDetailsFinanceEnumUseCase
      choixDesciptionDetailsFinanceEnumUseCase;
  final ChoixDesciptionEnumUseCase choixDesciptionEnumUseCase;
  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  late SharedPreferences _localDataactivSwitch;
  late double soldePrevisionel;
  late DateTime today = new DateTime.now();

  late SharedPreferences _localDataEcononyDays;

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
    this.generateGestionMensuelPrevisionUseCase,
    this.readContentUseCase,
    this.choixDesciptionUploadUseCase,
  ) {
    _initEconomy();
  }

  void _initEconomy() async {
    _localDataEcononyDays = await SharedPreferences.getInstance();

    _listGestionMensuel = await listGestionMensuelController.loadData();

    _listMontantUniverselle = await listMontantUniverselleController.loadData();

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

  achatTotals(String idGestionMensMontantUnv, int indexGestion,
      int indexGestionLive, int indexgestiondescription) async {
    await listGestionMensuelController.addAchatTotal(
      indexGestion: indexGestion,
      indexGestionLive: indexGestionLive,
      indexGestionDescription: indexgestiondescription,
      listGestionMensuel: _listGestionMensuel,
    );
    await listGestionMensuelController.updateMontantAchat(
        indexGestion, indexGestionLive, _listGestionMensuel);

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
    listMontantPrevisionController.resetListMontantPrevision(
        listMontantPrevision: _listMontantPrevision,
        listMontantUniverselle: _listMontantUniverselle);
    notifyListeners();
  }

  int idmontantUniverselle(int index) {
    int index2 = 0;
    for (var i = _listMontantPrevision.length - 1; i >= 0; i--) {
      if (_listMontantUniverselle[index].id == _listMontantPrevision[i].id) {
        index2 = i;
      }
    }
    return index2;
  }

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
            montantUniverselle: generateGestionMensuelPrevisionUseCase
                .execute(_listMontantUniverselle),
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
    await listGestionMensuelController.addGestionMensuelMontantUniv(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      index: index,
      listGestionMensuel: _listGestionMensuel,
    );
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
    await listGestionMensuelController.addGestionMensuelMontantUnivLive(
      icones: icones,
      nom: nom,
      montant: montant,
      id: id,
      unity: unity,
      index: index,
      listGestionMensuel: _listGestionMensuel,
    );

    _initEconomyDays();
    notifyListeners();
  }

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

  void removeGestionMensuelleMontantUnivLive(
      {required bool validation,
      required int indexGestionMensuel,
      required int indexGestionMensMontanUniv,
      required String idGestionMensMontanUniv}) async {
    listGestionMensuelController.removeGestionMensuelleMontantUnivLive(
      validation: validation,
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensMontanUniv: indexGestionMensMontanUniv,
      idGestionMensMontanUniv: idGestionMensMontanUniv,
      listGestionMensuel: _listGestionMensuel,
    );

    await listGestionMensuelController.saveGestionMensuelleMontantUniv(
        remove: true,
        idGestionMensMontanUniv: idGestionMensMontanUniv,
        listGestionMensuel: _listGestionMensuel);
    _initEconomy();
    notifyListeners();
  }

  void removeGestionDescriptionGestion(
      {required int index,
      required int indexGestionMensuel,
      required int indexGestionMensMontanUniv,
      required String idGestionMensMontanUniv}) async {
    listGestionMensuelController.removeGestionDescriptionGestion(
      index: index,
      indexGestionMensuel: indexGestionMensuel,
      idGestionMensMontanUniv: idGestionMensMontanUniv,
      listGestionMensuel: _listGestionMensuel,
      indexGestionMensuelMontantUniv: indexGestionMensMontanUniv,
    );

    notifyListeners();
  }

  void removeGestionMensuelleMontantUniv(
      {required bool validation,
      required int indexGestionMensuel,
      required int indexGestionMensMontanUniv,
      required String idGestionMensMontanUniv}) async {
    listGestionMensuelController.removeGestionMensuelleMontantUniv(
      indexGestionMensuel: indexGestionMensuel,
      indexGestionMensMontanUniv: indexGestionMensMontanUniv,
      idGestionMensMontanUniv: idGestionMensMontanUniv,
      listGestionMensuel: _listGestionMensuel,
      validation: validation,
    );

    notifyListeners();
  }

  echeancePasseMontanUnive(String idGestionMensMontantUnv, int indexGestion,
      int indexGestionLive) async {
    await listMontantUniverselleController.echeancePasseMontanUnive(
      idGestionMensMontantUnv: idGestionMensMontantUnv,
      indexGestion: indexGestion,
      indexGestionLive: indexGestionLive,
      listMontantUniverselle: _listMontantUniverselle,
      listGestionMensuel: _listGestionMensuel,
    );

    notifyListeners();
  }

  echeanceNoPasseMontanUnive(String idGestionMensMontantUnv, int indexGestion,
      int indexGestionLive) async {
    await listMontantUniverselleController.echeanceNoPasseMontanUnive(
      idGestionMensMontantUnv: idGestionMensMontantUnv,
      indexGestion: indexGestion,
      indexGestionLive: indexGestionLive,
      listMontantUniverselle: _listMontantUniverselle,
      listGestionMensuel: _listGestionMensuel,
    );

    notifyListeners();
  }

  void changePrix({
    required String montant,
    required int indexGestion,
  }) async {
    await listMontantUniverselleController.changePrix(
      montant: montant,
      indexGestion: indexGestion,
      listMontantUniverselle: _listMontantUniverselle,
    );
    notifyListeners();
  }

  void changeTitre({
    required String nom,
    required int indexGestion,
  }) async {
    await listMontantUniverselleController.changeTitre(
      nom: nom,
      indexGestion: indexGestion,
      listMontantUniverselle: _listMontantUniverselle,
    );
    notifyListeners();
  }

  void changeIcons({
    required int icons,
    required int indexGestion,
  }) async {
    await listMontantUniverselleController.changeIcons(
      icons: icons,
      indexGestion: indexGestion,
      listMontantUniverselle: _listMontantUniverselle,
    );
    notifyListeners();
  }

  void changePrixSimulation({
    required String montant,
    required int indexGestion,
  }) async {
    await listMontantPrevisionController.changePrixSimulation(
      montant: montant,
      indexGestion: indexGestion,
      listMontantPrevision: _listMontantPrevision,
    );
    notifyListeners();
  }

  void changeTitreSimulation({
    required String nom,
    required int indexGestion,
  }) async {
    await listMontantPrevisionController.changeTitreSimulation(
      nom: nom,
      indexGestion: indexGestion,
      listMontantPrevision: _listMontantPrevision,
    );
    notifyListeners();
  }

  void changeIconsSimulation({
    required int icons,
    required int indexGestion,
  }) async {
    await listMontantPrevisionController.changeIconsSimulation(
      icons: icons,
      indexGestion: indexGestion,
      listMontantPrevision: _listMontantPrevision,
    );
    notifyListeners();
  }

  void changePrixGestionMensuel({
    required String montant,
    required int indexGestionMensuel,
    required int indexGestion,
  }) async {
    await listGestionMensuelController.changePrixGestionMensuel(
      montant: montant,
      indexGestionMensuel: indexGestionMensuel,
      indexGestion: indexGestion,
      listGestionMensuel: _listGestionMensuel,
    );
    notifyListeners();
  }

  void changeTitreGestionMensuel({
    required String nom,
    required int indexGestionMensuel,
    required int indexGestion,
  }) async {
    await listGestionMensuelController.changeTitreGestionMensuel(
      nom: nom,
      indexGestionMensuel: indexGestionMensuel,
      indexGestion: indexGestion,
      listGestionMensuel: _listGestionMensuel,
    );
    _initEconomy();
    notifyListeners();
  }

  void changeIconsGestionMensuel({
    required int icons,
    required int indexGestionMensuel,
    required int indexGestion,
  }) async {
    await listGestionMensuelController.changeIconsGestionMensuel(
      icons: icons,
      indexGestionMensuel: indexGestionMensuel,
      indexGestion: indexGestion,
      listGestionMensuel: _listGestionMensuel,
    );
    notifyListeners();
  }

  activeListListMontantUniverselle({required int index}) async {
    await listMontantUniverselleController.toggleActiveMontantUniverselle(
      index: index,
      listMontantUniverselle: _listMontantUniverselle,
    );
    notifyListeners();
  }

  activeListListMontantPrevision({required int index}) async {
    await listMontantPrevisionController.toggleActiveMontantPrevision(
      index: index,
      listMontantPrevision: _listMontantPrevision,
    );
    notifyListeners();
  }

  activeListListGestionMensuel(
      {required int indexGestionMensuel, required int indexGestion}) async {
    await listGestionMensuelController.toggleActiveGestionMensuel(
      indexGestionMensuel: indexGestionMensuel,
      indexGestion: indexGestion,
      listGestionMensuel: _listGestionMensuel,
    );

    notifyListeners();
  }

  void uploadChallenge() async {
    UploadMontantniversell uploadFileChallenge =
        UploadMontantniversell(montantUniverselle: []);
    Map<String, dynamic> _jsonDecodeuploadFile;
    String uploadFile = await readContentUseCase.execute();
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
            unity: choixDesciptionUploadUseCase
                .execute(uploadFileChallenge.montantUniverselle[i].unity),
            icones: uploadFileChallenge.montantUniverselle[i].icones);
      }
    }
  }

  void addMontanUniverselleUpload() async {
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
  }

  void switchTrueIntro(bool active) async {
    if (active) {
      activSwitch.active = "true";
    } else {
      activSwitch.active = "false";
    }
    await _saveChallenyesterday();
  
  }

  void initChallengeyesterday() async {
    DateTime today = new DateTime.now();
    DateTime lastDay =
        DateFormat('EEEE, d MMM, yyyy').parseStrict(activSwitch.date);

    if ((today.day >= (lastDay.day + 1)) && (today.month > lastDay.month)) {
      if (activSwitch.firstActive == "true") {
        activSwitch.firstActive = "false";
        activSwitch.active = "false";
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
