// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../controllers/list_gestion_mensuel_controller.dart' as _i23;
import '../controllers/list_montant_prevision_controller.dart' as _i24;
import '../controllers/list_montant_universelle_controller.dart' as _i25;
import '../mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart'
    as _i7;
import '../useCases/choix_desciption_details_finance_enum_usecase.dart' as _i3;
import '../useCases/choix_description_enum_usecase.dart' as _i4;
import '../useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart'
    as _i16;
import '../useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart'
    as _i19;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart'
    as _i22;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart'
    as _i11;
import '../useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart'
    as _i17;
import '../useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart'
    as _i20;
import '../useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart'
    as _i15;
import '../useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart'
    as _i18;
import '../useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart'
    as _i21;
import '../useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart'
    as _i14;
import 'gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart'
    as _i5;
import 'gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart'
    as _i10;
import 'montantPrevision/montant_prevision_get_data_sharedpreferencies.dart'
    as _i8;
import 'montantPrevision/save_montant_prevision_sharedpreferencies.dart'
    as _i12;
import 'montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart'
    as _i9;
import 'montantUniverselleServices/save_montant_universelle_sharedpreferencies.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i8.MontantPrevisionGetDataSharedPreferences>(() =>
      _i8.MontantPrevisionGetDataSharedPreferences(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i9.MontantUniverselleGetDataSharedpreferencies>(
      _i9.MontantUniverselleGetDataSharedpreferencies(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i10.SaveGestionMensuelSharedPreferencesService>(
      _i10.SaveGestionMensuelSharedPreferencesService(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i11.SaveGestionMensuelUseCase>(_i11.SaveGestionMensuelUseCase(
      get<_i10.SaveGestionMensuelSharedPreferencesService>()));
  gh.factory<_i12.SaveMontantPrevisionSharedPreferencesService>(() =>
      _i12.SaveMontantPrevisionSharedPreferencesService(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i13.SaveMontantUniverselleSharedPreferencesService>(
      _i13.SaveMontantUniverselleSharedPreferencesService(
          get<_i6.SharedPreferences>()));
  gh.singleton<_i14.SaveMontantUniverselleUseCase>(
      _i14.SaveMontantUniverselleUseCase(
          get<_i13.SaveMontantUniverselleSharedPreferencesService>()));
  gh.singleton<_i15.SaveMontantprevisionUseCase>(
      _i15.SaveMontantprevisionUseCase(
          get<_i12.SaveMontantPrevisionSharedPreferencesService>()));
  gh.factory<_i16.AddMontantGestionUseCase>(() => _i16.AddMontantGestionUseCase(
        get<_i11.SaveGestionMensuelUseCase>(),
        get<_i3.ChoixDesciptionDetailsFinanceEnumUseCase>(),
      ));
  gh.factory<_i17.AddMontantPrevisionUseCase>(
      () => _i17.AddMontantPrevisionUseCase(
            get<_i15.SaveMontantprevisionUseCase>(),
            get<_i3.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i18.AddMontantUniverselleUseCase>(
      () => _i18.AddMontantUniverselleUseCase(
            get<_i3.ChoixDesciptionDetailsFinanceEnumUseCase>(),
            get<_i16.AddMontantGestionUseCase>(),
            get<_i14.SaveMontantUniverselleUseCase>(),
          ));
  gh.singleton<_i19.LoadGestionMensuelUseCase>(_i19.LoadGestionMensuelUseCase(
      get<_i7.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i20.LoadMontantPrevisionUseCase>(
      _i20.LoadMontantPrevisionUseCase(
          get<_i7.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i21.LoadMontantUniverselleUseCase>(
      _i21.LoadMontantUniverselleUseCase(
          get<_i7.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.factory<_i22.RemoveGestionMensuelUseCase>(() =>
      _i22.RemoveGestionMensuelUseCase(get<_i11.SaveGestionMensuelUseCase>()));
  gh.singleton<_i23.ListGestionMensuelController>(
      _i23.ListGestionMensuelController(
    get<_i5.GestionMensuelGetDataSharedpreferencies>(),
    get<_i7.MapperListGestionMensuelJsonToModelUseCase>(),
    get<_i19.LoadGestionMensuelUseCase>(),
    get<_i11.SaveGestionMensuelUseCase>(),
  ));
  gh.singleton<_i24.ListMontantPrevisionController>(
      _i24.ListMontantPrevisionController(
    get<_i8.MontantPrevisionGetDataSharedPreferences>(),
    get<_i20.LoadMontantPrevisionUseCase>(),
    get<_i15.SaveMontantprevisionUseCase>(),
  ));
  gh.singleton<_i25.ListMontantUniverselleController>(
      _i25.ListMontantUniverselleController(
    get<_i9.MontantUniverselleGetDataSharedpreferencies>(),
    get<_i21.LoadMontantUniverselleUseCase>(),
    get<_i14.SaveMontantUniverselleUseCase>(),
  ));
  return get;
}
