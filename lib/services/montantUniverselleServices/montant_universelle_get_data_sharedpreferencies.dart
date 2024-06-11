import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class MontantUniverselleGetDataSharedpreferencies {
  final SharedPreferences _localData;

  MontantUniverselleGetDataSharedpreferencies(this._localData);

  Future<List<String>?> execute() async {
    return _localData.getStringList(keyAccesMontantUniverselle);
  }
}
