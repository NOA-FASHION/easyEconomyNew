// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../controllers/list_gestion_mensuel_controller.dart' as _i17;
import '../controllers/list_montant_universelle_controller.dart' as _i18;
import '../mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart'
    as _i7;
import '../useCases/choix_desciption_details_finance_enum_usecase.dart' as _i3;
import '../useCases/choix_description_enum_usecase.dart' as _i4;
import '../useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart'
    as _i13;
import '../useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart'
    as _i14;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart'
    as _i16;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart'
    as _i10;
import '../useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart'
    as _i15;
import '../useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart'
    as _i12;
import 'gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart'
    as _i5;
import 'gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart'
    as _i9;
import 'montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart'
    as _i8;
import 'montantUniverselleServices/save_montant_universelle_sharedpreferencies.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.ChoixDesciptionDetailsFinanceEnumUseCase>(
      () => _i3.ChoixDesciptionDetailsFinanceEnumUseCase());
  gh.factory<_i4.ChoixDesciptionEnumUseCase>(
      () => _i4.ChoixDesciptionEnumUseCase());
  gh.singleton<_i5.GestionMensuelGetDataSharedpreferencies>(
      _i5.GestionMensuelGetDataSharedpreferencies(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i7.MapperListGestionMensuelJsonToModelUseCase>(
      _i7.MapperListGestionMensuelJsonToModelUseCase());
  gh.singleton<_i8.MontantUniverselleGetDataSharedpreferencies>(
      _i8.MontantUniverselleGetDataSharedpreferencies(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i9.SaveGestionMensuelSharedPreferencesService>(
      _i9.SaveGestionMensuelSharedPreferencesService(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i10.SaveGestionMensuelUseCase>(_i10.SaveGestionMensuelUseCase(
      get<_i9.SaveGestionMensuelSharedPreferencesService>()));
  gh.singleton<_i11.SaveMontantUniverselleSharedPreferencesService>(
      _i11.SaveMontantUniverselleSharedPreferencesService(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i12.SaveMontantUniverselleUseCase>(
      _i12.SaveMontantUniverselleUseCase(
          get<_i11.SaveMontantUniverselleSharedPreferencesService>()));
  gh.singleton<_i13.AddMontantGestionUseCase>(_i13.AddMontantGestionUseCase(
    get<_i10.SaveGestionMensuelUseCase>(),
    get<_i3.ChoixDesciptionDetailsFinanceEnumUseCase>(),
  ));
  gh.singleton<_i14.LoadGestionMensuelUseCase>(_i14.LoadGestionMensuelUseCase(
      get<_i7.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i15.LoadMontantUniverselleUseCase>(
      _i15.LoadMontantUniverselleUseCase(
          get<_i7.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i16.RemoveGestionMensuelUseCase>(
      _i16.RemoveGestionMensuelUseCase(get<_i10.SaveGestionMensuelUseCase>()));
  gh.singleton<_i17.ListGestionMensuelController>(
      _i17.ListGestionMensuelController(
    get<_i5.GestionMensuelGetDataSharedpreferencies>(),
    get<_i7.MapperListGestionMensuelJsonToModelUseCase>(),
    get<_i14.LoadGestionMensuelUseCase>(),
    get<_i10.SaveGestionMensuelUseCase>(),
  ));
  gh.singleton<_i18.ListMontantUniverselleController>(
      _i18.ListMontantUniverselleController(
    get<_i8.MontantUniverselleGetDataSharedpreferencies>(),
    get<_i15.LoadMontantUniverselleUseCase>(),
    get<_i12.SaveMontantUniverselleUseCase>(),
  ));
  return get;
}
