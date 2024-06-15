// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../controllers/list_gestion_mensuel_controller.dart' as _i33;
import '../controllers/list_montant_prevision_controller.dart' as _i34;
import '../controllers/list_montant_universelle_controller.dart' as _i35;
import '../mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart'
    as _i9;
import '../useCases/choix_desciption_details_finance_enum_usecase.dart' as _i5;
import '../useCases/choix_description_enum_usecase.dart' as _i6;
import '../useCases/gestionMensuelUsecase/add_achat_total_usecase.dart' as _i20;
import '../useCases/gestionMensuelUsecase/add_description_gestion_usecase.dart'
    as _i21;
import '../useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart'
    as _i23;
import '../useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart'
    as _i3;
import '../useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart'
    as _i4;
import '../useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart'
    as _i26;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart'
    as _i30;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart'
    as _i13;
import '../useCases/gestionMensuelUsecase/update_montant_achat_usecase.dart'
    as _i18;
import '../useCases/gestionMensuelUsecase/update_montant_prevision_usecase.dart'
    as _i19;
import '../useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart'
    as _i24;
import '../useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart'
    as _i27;
import '../useCases/montantPrevisionUsecase/remove_montant_prevision_usecase.dart'
    as _i31;
import '../useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart'
    as _i17;
import '../useCases/montantUniverselleUsecase/add_description_montant_universelle_usecase.dart'
    as _i22;
import '../useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart'
    as _i25;
import '../useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart'
    as _i28;
import '../useCases/montantUniverselleUsecase/remove_description_montant_universelle_usecase.dart'
    as _i29;
import '../useCases/montantUniverselleUsecase/remove_montant_universelle_usecase.dart'
    as _i32;
import '../useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart'
    as _i16;
import 'gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart'
    as _i7;
import 'gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart'
    as _i12;
import 'montantPrevision/montant_prevision_get_data_sharedpreferencies.dart'
    as _i10;
import 'montantPrevision/save_montant_prevision_sharedpreferencies.dart'
    as _i14;
import 'montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart'
    as _i11;
import 'montantUniverselleServices/save_montant_universelle_sharedpreferencies.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.CalculateTotalAchatUseCase>(
      () => _i3.CalculateTotalAchatUseCase());
  gh.factory<_i4.CalculateTotalPrevisionUseCase>(
      () => _i4.CalculateTotalPrevisionUseCase());
  gh.factory<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(
      () => _i5.ChoixDesciptionDetailsFinanceEnumUseCase());
  gh.factory<_i6.ChoixDesciptionEnumUseCase>(
      () => _i6.ChoixDesciptionEnumUseCase());
  gh.singleton<_i7.GestionMensuelGetDataSharedpreferencies>(
      _i7.GestionMensuelGetDataSharedpreferencies(
          get<_i8.SharedPreferences>()));
  gh.singleton<_i9.MapperListGestionMensuelJsonToModelUseCase>(
      _i9.MapperListGestionMensuelJsonToModelUseCase());
  gh.factory<_i10.MontantPrevisionGetDataSharedPreferences>(() =>
      _i10.MontantPrevisionGetDataSharedPreferences(
          get<_i8.SharedPreferences>()));
  gh.singleton<_i11.MontantUniverselleGetDataSharedpreferencies>(
      _i11.MontantUniverselleGetDataSharedpreferencies(
          get<_i8.SharedPreferences>()));
  gh.singleton<_i12.SaveGestionMensuelSharedPreferencesService>(
      _i12.SaveGestionMensuelSharedPreferencesService(
          get<_i8.SharedPreferences>()));
  gh.singleton<_i13.SaveGestionMensuelUseCase>(_i13.SaveGestionMensuelUseCase(
      get<_i12.SaveGestionMensuelSharedPreferencesService>()));
  gh.factory<_i14.SaveMontantPrevisionSharedPreferencesService>(() =>
      _i14.SaveMontantPrevisionSharedPreferencesService(
          get<_i8.SharedPreferences>()));
  gh.singleton<_i15.SaveMontantUniverselleSharedPreferencesService>(
      _i15.SaveMontantUniverselleSharedPreferencesService(
          get<_i8.SharedPreferences>()));
  gh.singleton<_i16.SaveMontantUniverselleUseCase>(
      _i16.SaveMontantUniverselleUseCase(
          get<_i15.SaveMontantUniverselleSharedPreferencesService>()));
  gh.singleton<_i17.SaveMontantprevisionUseCase>(
      _i17.SaveMontantprevisionUseCase(
          get<_i14.SaveMontantPrevisionSharedPreferencesService>()));
  gh.factory<_i18.UpdateMontantAchatUseCase>(
      () => _i18.UpdateMontantAchatUseCase(
            get<_i3.CalculateTotalAchatUseCase>(),
            get<_i13.SaveGestionMensuelUseCase>(),
          ));
  gh.factory<_i19.UpdateMontantPrevisionUseCase>(
      () => _i19.UpdateMontantPrevisionUseCase(
            get<_i4.CalculateTotalPrevisionUseCase>(),
            get<_i13.SaveGestionMensuelUseCase>(),
          ));
  gh.factory<_i20.AddAchatTotalUseCase>(
      () => _i20.AddAchatTotalUseCase(get<_i13.SaveGestionMensuelUseCase>()));
  gh.factory<_i21.AddDescriptionGestionUseCase>(
      () => _i21.AddDescriptionGestionUseCase(
            get<_i13.SaveGestionMensuelUseCase>(),
            get<_i6.ChoixDesciptionEnumUseCase>(),
          ));
  gh.factory<_i22.AddDescriptionMontantUniverselleUseCase>(
      () => _i22.AddDescriptionMontantUniverselleUseCase(
            get<_i6.ChoixDesciptionEnumUseCase>(),
            get<_i16.SaveMontantUniverselleUseCase>(),
          ));
  gh.factory<_i23.AddMontantGestionUseCase>(() => _i23.AddMontantGestionUseCase(
        get<_i13.SaveGestionMensuelUseCase>(),
        get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
      ));
  gh.factory<_i24.AddMontantPrevisionUseCase>(
      () => _i24.AddMontantPrevisionUseCase(
            get<_i17.SaveMontantprevisionUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i25.AddMontantUniverselleUseCase>(
      () => _i25.AddMontantUniverselleUseCase(
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
            get<_i23.AddMontantGestionUseCase>(),
            get<_i16.SaveMontantUniverselleUseCase>(),
          ));
  gh.singleton<_i26.LoadGestionMensuelUseCase>(_i26.LoadGestionMensuelUseCase(
      get<_i9.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i27.LoadMontantPrevisionUseCase>(
      _i27.LoadMontantPrevisionUseCase(
          get<_i9.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i28.LoadMontantUniverselleUseCase>(
      _i28.LoadMontantUniverselleUseCase(
          get<_i9.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.factory<_i29.RemoveDescriptionMontantUniverselleUseCase>(() =>
      _i29.RemoveDescriptionMontantUniverselleUseCase(
          get<_i16.SaveMontantUniverselleUseCase>()));
  gh.factory<_i30.RemoveGestionMensuelUseCase>(() =>
      _i30.RemoveGestionMensuelUseCase(get<_i13.SaveGestionMensuelUseCase>()));
  gh.factory<_i31.RemoveMontantPrevisionUseCase>(() =>
      _i31.RemoveMontantPrevisionUseCase(
          get<_i17.SaveMontantprevisionUseCase>()));
  gh.factory<_i32.RemoveMontantUniverselleUseCase>(() =>
      _i32.RemoveMontantUniverselleUseCase(
          get<_i16.SaveMontantUniverselleUseCase>()));
  gh.singleton<_i33.ListGestionMensuelController>(
      _i33.ListGestionMensuelController(
    get<_i7.GestionMensuelGetDataSharedpreferencies>(),
    get<_i9.MapperListGestionMensuelJsonToModelUseCase>(),
    get<_i26.LoadGestionMensuelUseCase>(),
    get<_i13.SaveGestionMensuelUseCase>(),
    get<_i23.AddMontantGestionUseCase>(),
    get<_i30.RemoveGestionMensuelUseCase>(),
    get<_i4.CalculateTotalPrevisionUseCase>(),
    get<_i3.CalculateTotalAchatUseCase>(),
    get<_i19.UpdateMontantPrevisionUseCase>(),
    get<_i18.UpdateMontantAchatUseCase>(),
    get<_i20.AddAchatTotalUseCase>(),
    get<_i21.AddDescriptionGestionUseCase>(),
  ));
  gh.singleton<_i34.ListMontantPrevisionController>(
      _i34.ListMontantPrevisionController(
    get<_i10.MontantPrevisionGetDataSharedPreferences>(),
    get<_i27.LoadMontantPrevisionUseCase>(),
    get<_i17.SaveMontantprevisionUseCase>(),
    get<_i31.RemoveMontantPrevisionUseCase>(),
    get<_i24.AddMontantPrevisionUseCase>(),
  ));
  gh.singleton<_i35.ListMontantUniverselleController>(
      _i35.ListMontantUniverselleController(
    get<_i11.MontantUniverselleGetDataSharedpreferencies>(),
    get<_i28.LoadMontantUniverselleUseCase>(),
    get<_i16.SaveMontantUniverselleUseCase>(),
    get<_i25.AddMontantUniverselleUseCase>(),
    get<_i32.RemoveMontantUniverselleUseCase>(),
    get<_i22.AddDescriptionMontantUniverselleUseCase>(),
    get<_i29.RemoveDescriptionMontantUniverselleUseCase>(),
  ));
  return get;
}
