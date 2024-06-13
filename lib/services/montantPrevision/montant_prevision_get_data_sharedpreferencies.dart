import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class MontantPrevisionGetDataSharedPreferences {
  final SharedPreferences _localData;

  MontantPrevisionGetDataSharedPreferences(this._localData);

  Future<List<String>?> execute() async {
    return _localData.getStringList(keyAccesMontantPrevision);
  }
}
