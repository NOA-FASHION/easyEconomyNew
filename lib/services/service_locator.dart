import 'package:easyeconomy/services/service_locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureDependencies(SharedPreferences sharedPreferences) {
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  $initGetIt(getIt);
}