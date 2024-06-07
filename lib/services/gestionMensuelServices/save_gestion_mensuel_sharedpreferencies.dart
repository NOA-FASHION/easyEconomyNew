import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class SaveGestionMensuelSharedPreferencesService {
  final SharedPreferences _localData;

  SaveGestionMensuelSharedPreferencesService(this._localData);

  Future<bool> saveData(List<String> data) async {
    return _localData.setStringList(keyAcces, data);
  }
}
