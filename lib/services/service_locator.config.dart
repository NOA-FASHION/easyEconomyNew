// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import '../controllers/list_gestion_mensuel_controller.dart' as _i11;
import '../mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart'
    as _i5;
import '../useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart'
    as _i8;
import '../useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart'
    as _i9;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart'
    as _i10;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart'
    as _i7;
import 'gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart'
    as _i3;
import 'gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.GestionMensuelGetDataSharedpreferencies>(
      _i3.GestionMensuelGetDataSharedpreferencies(
          get<_i4.SharedPreferences>()));
  gh.singleton<_i5.MapperListGestionMensuelJsonToModelUseCase>(
      _i5.MapperListGestionMensuelJsonToModelUseCase());
  gh.singleton<_i6.SaveGestionMensuelSharedPreferencesService>(
      _i6.SaveGestionMensuelSharedPreferencesService(
          get<_i4.SharedPreferences>()));
  gh.singleton<_i7.SaveGestionMensuelUseCase>(_i7.SaveGestionMensuelUseCase(
      get<_i6.SaveGestionMensuelSharedPreferencesService>()));
  gh.singleton<_i8.AddMontantGestionUseCase>(
      _i8.AddMontantGestionUseCase(get<_i7.SaveGestionMensuelUseCase>()));
  gh.singleton<_i9.LoadGestionMensuelUseCase>(_i9.LoadGestionMensuelUseCase(
      get<_i5.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i10.RemoveGestionMensuelUseCase>(
      _i10.RemoveGestionMensuelUseCase(get<_i7.SaveGestionMensuelUseCase>()));
  gh.singleton<_i11.ListGestionMensuelController>(
      _i11.ListGestionMensuelController(
    get<_i3.GestionMensuelGetDataSharedpreferencies>(),
    get<_i5.MapperListGestionMensuelJsonToModelUseCase>(),
    get<_i9.LoadGestionMensuelUseCase>(),
    get<_i7.SaveGestionMensuelUseCase>(),
  ));
  return get;
}
