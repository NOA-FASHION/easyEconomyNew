import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SaveMontantPrevisionSharedPreferencesService {
  final SharedPreferences _localData;

  SaveMontantPrevisionSharedPreferencesService(this._localData);

  Future<bool> saveData(List<String> data) async {
    return _localData.setStringList(keyAccesMontantPrevision, data);
  }
}
