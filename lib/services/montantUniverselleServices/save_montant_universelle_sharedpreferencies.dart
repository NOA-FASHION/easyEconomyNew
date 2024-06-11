import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class SaveMontantUniverselleSharedPreferencesService {
  final SharedPreferences _localData;

  SaveMontantUniverselleSharedPreferencesService(this._localData);

  Future<bool> saveData(List<String> data) async {
    return _localData.setStringList(keyAccesMontantUniverselle, data);
  }
}
