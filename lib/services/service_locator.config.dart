// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../controllers/list_gestion_mensuel_controller.dart' as _i42;
import '../controllers/list_montant_prevision_controller.dart' as _i43;
import '../controllers/list_montant_universelle_controller.dart' as _i44;
import '../mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart'
    as _i10;
import '../useCases/choix_desciption_details_finance_enum_usecase.dart' as _i5;
import '../useCases/choix_description_enum_usecase.dart' as _i6;
import '../useCases/generate_gestion_mensuel_prevision_usecase.dart' as _i7;
import '../useCases/gestionMensuelUsecase/add_achat_total_usecase.dart' as _i23;
import '../useCases/gestionMensuelUsecase/add_description_gestion_usecase.dart'
    as _i24;
import '../useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_live_usecase.dart'
    as _i26;
import '../useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_usecase.dart'
    as _i27;
import '../useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart'
    as _i28;
import '../useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart'
    as _i3;
import '../useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart'
    as _i4;
import '../useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart'
    as _i31;
import '../useCases/gestionMensuelUsecase/remove_gestion_description_gestion_usecase.dart'
    as _i35;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart'
    as _i36;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_live_usecase.dart'
    as _i37;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_usecase.dart'
    as _i38;
import '../useCases/gestionMensuelUsecase/save_description_gestion_usecase.dart'
    as _i13;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart'
    as _i15;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuelle_montant_univ_usecase.dart'
    as _i16;
import '../useCases/gestionMensuelUsecase/update_montant_achat_usecase.dart'
    as _i21;
import '../useCases/gestionMensuelUsecase/update_montant_prevision_usecase.dart'
    as _i22;
import '../useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart'
    as _i29;
import '../useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart'
    as _i32;
import '../useCases/montantPrevisionUsecase/remove_montant_prevision_usecase.dart'
    as _i39;
import '../useCases/montantPrevisionUsecase/reset_list_montant_prevision_usecase.dart'
    as _i41;
import '../useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart'
    as _i20;
import '../useCases/montantUniverselleUsecase/add_description_montant_universelle_usecase.dart'
    as _i25;
import '../useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart'
    as _i30;
import '../useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart'
    as _i33;
import '../useCases/montantUniverselleUsecase/remove_description_montant_universelle_usecase.dart'
    as _i34;
import '../useCases/montantUniverselleUsecase/remove_montant_universelle_usecase.dart'
    as _i40;
import '../useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart'
    as _i19;
import 'gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart'
    as _i8;
import 'gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart'
    as _i14;
import 'montantPrevision/montant_prevision_get_data_sharedpreferencies.dart'
    as _i11;
import 'montantPrevision/save_montant_prevision_sharedpreferencies.dart'
    as _i17;
import 'montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart'
    as _i12;
import 'montantUniverselleServices/save_montant_universelle_sharedpreferencies.dart'
    as _i18; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.GenerateGestionMensuelPrevisionUseCase>(
      () => _i7.GenerateGestionMensuelPrevisionUseCase());
  gh.singleton<_i8.GestionMensuelGetDataSharedpreferencies>(
      _i8.GestionMensuelGetDataSharedpreferencies(
          get<_i9.SharedPreferences>()));
  gh.singleton<_i10.MapperListGestionMensuelJsonToModelUseCase>(
      _i10.MapperListGestionMensuelJsonToModelUseCase());
  gh.factory<_i11.MontantPrevisionGetDataSharedPreferences>(() =>
      _i11.MontantPrevisionGetDataSharedPreferences(
          get<_i9.SharedPreferences>()));
  gh.singleton<_i12.MontantUniverselleGetDataSharedpreferencies>(
      _i12.MontantUniverselleGetDataSharedpreferencies(
          get<_i9.SharedPreferences>()));
  gh.factory<_i13.SaveDescriptionGestionUseCase>(
      () => _i13.SaveDescriptionGestionUseCase(get<_i9.SharedPreferences>()));
  gh.singleton<_i14.SaveGestionMensuelSharedPreferencesService>(
      _i14.SaveGestionMensuelSharedPreferencesService(
          get<_i9.SharedPreferences>()));
  gh.singleton<_i15.SaveGestionMensuelUseCase>(_i15.SaveGestionMensuelUseCase(
      get<_i14.SaveGestionMensuelSharedPreferencesService>()));
  gh.factory<_i16.SaveGestionMensuelleMontantUnivUseCase>(() =>
      _i16.SaveGestionMensuelleMontantUnivUseCase(
          get<_i9.SharedPreferences>()));
  gh.factory<_i17.SaveMontantPrevisionSharedPreferencesService>(() =>
      _i17.SaveMontantPrevisionSharedPreferencesService(
          get<_i9.SharedPreferences>()));
  gh.singleton<_i18.SaveMontantUniverselleSharedPreferencesService>(
      _i18.SaveMontantUniverselleSharedPreferencesService(
          get<_i9.SharedPreferences>()));
  gh.singleton<_i19.SaveMontantUniverselleUseCase>(
      _i19.SaveMontantUniverselleUseCase(
          get<_i18.SaveMontantUniverselleSharedPreferencesService>()));
  gh.singleton<_i20.SaveMontantprevisionUseCase>(
      _i20.SaveMontantprevisionUseCase(
          get<_i17.SaveMontantPrevisionSharedPreferencesService>()));
  gh.factory<_i21.UpdateMontantAchatUseCase>(
      () => _i21.UpdateMontantAchatUseCase(
            get<_i3.CalculateTotalAchatUseCase>(),
            get<_i15.SaveGestionMensuelUseCase>(),
          ));
  gh.factory<_i22.UpdateMontantPrevisionUseCase>(
      () => _i22.UpdateMontantPrevisionUseCase(
            get<_i4.CalculateTotalPrevisionUseCase>(),
            get<_i15.SaveGestionMensuelUseCase>(),
          ));
  gh.factory<_i23.AddAchatTotalUseCase>(
      () => _i23.AddAchatTotalUseCase(get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i24.AddDescriptionGestionUseCase>(
      () => _i24.AddDescriptionGestionUseCase(
            get<_i15.SaveGestionMensuelUseCase>(),
            get<_i6.ChoixDesciptionEnumUseCase>(),
          ));
  gh.factory<_i25.AddDescriptionMontantUniverselleUseCase>(
      () => _i25.AddDescriptionMontantUniverselleUseCase(
            get<_i6.ChoixDesciptionEnumUseCase>(),
            get<_i19.SaveMontantUniverselleUseCase>(),
          ));
  gh.factory<_i26.AddGestionMensuelMontantUnivLiveUseCase>(
      () => _i26.AddGestionMensuelMontantUnivLiveUseCase(
            get<_i15.SaveGestionMensuelUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i27.AddGestionMensuelMontantUnivUseCase>(
      () => _i27.AddGestionMensuelMontantUnivUseCase(
            get<_i15.SaveGestionMensuelUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i28.AddMontantGestionUseCase>(() => _i28.AddMontantGestionUseCase(
        get<_i15.SaveGestionMensuelUseCase>(),
        get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
      ));
  gh.factory<_i29.AddMontantPrevisionUseCase>(
      () => _i29.AddMontantPrevisionUseCase(
            get<_i20.SaveMontantprevisionUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i30.AddMontantUniverselleUseCase>(
      () => _i30.AddMontantUniverselleUseCase(
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
            get<_i28.AddMontantGestionUseCase>(),
            get<_i19.SaveMontantUniverselleUseCase>(),
          ));
  gh.singleton<_i31.LoadGestionMensuelUseCase>(_i31.LoadGestionMensuelUseCase(
      get<_i10.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i32.LoadMontantPrevisionUseCase>(
      _i32.LoadMontantPrevisionUseCase(
          get<_i10.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i33.LoadMontantUniverselleUseCase>(
      _i33.LoadMontantUniverselleUseCase(
          get<_i10.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.factory<_i34.RemoveDescriptionMontantUniverselleUseCase>(() =>
      _i34.RemoveDescriptionMontantUniverselleUseCase(
          get<_i19.SaveMontantUniverselleUseCase>()));
  gh.factory<_i35.RemoveGestionDescriptionGestionUseCase>(() =>
      _i35.RemoveGestionDescriptionGestionUseCase(
          get<_i13.SaveDescriptionGestionUseCase>()));
  gh.factory<_i36.RemoveGestionMensuelUseCase>(() =>
      _i36.RemoveGestionMensuelUseCase(get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i37.RemoveGestionMensuelleMontantUnivLiveUseCase>(() =>
      _i37.RemoveGestionMensuelleMontantUnivLiveUseCase(
          get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i38.RemoveGestionMensuelleMontantUnivUseCase>(() =>
      _i38.RemoveGestionMensuelleMontantUnivUseCase(
          get<_i16.SaveGestionMensuelleMontantUnivUseCase>()));
  gh.factory<_i39.RemoveMontantPrevisionUseCase>(() =>
      _i39.RemoveMontantPrevisionUseCase(
          get<_i20.SaveMontantprevisionUseCase>()));
  gh.factory<_i40.RemoveMontantUniverselleUseCase>(() =>
      _i40.RemoveMontantUniverselleUseCase(
          get<_i19.SaveMontantUniverselleUseCase>()));
  gh.factory<_i41.ResetListMontantPrevisionUseCase>(() =>
      _i41.ResetListMontantPrevisionUseCase(
          get<_i20.SaveMontantprevisionUseCase>()));
  gh.singleton<_i42.ListGestionMensuelController>(
      _i42.ListGestionMensuelController(
    get<_i8.GestionMensuelGetDataSharedpreferencies>(),
    get<_i10.MapperListGestionMensuelJsonToModelUseCase>(),
    get<_i31.LoadGestionMensuelUseCase>(),
    get<_i15.SaveGestionMensuelUseCase>(),
    get<_i28.AddMontantGestionUseCase>(),
    get<_i36.RemoveGestionMensuelUseCase>(),
    get<_i4.CalculateTotalPrevisionUseCase>(),
    get<_i3.CalculateTotalAchatUseCase>(),
    get<_i22.UpdateMontantPrevisionUseCase>(),
    get<_i21.UpdateMontantAchatUseCase>(),
    get<_i23.AddAchatTotalUseCase>(),
    get<_i24.AddDescriptionGestionUseCase>(),
    get<_i27.AddGestionMensuelMontantUnivUseCase>(),
    get<_i26.AddGestionMensuelMontantUnivLiveUseCase>(),
    get<_i37.RemoveGestionMensuelleMontantUnivLiveUseCase>(),
    get<_i13.SaveDescriptionGestionUseCase>(),
    get<_i16.SaveGestionMensuelleMontantUnivUseCase>(),
    get<_i35.RemoveGestionDescriptionGestionUseCase>(),
    get<_i38.RemoveGestionMensuelleMontantUnivUseCase>(),
  ));
  gh.singleton<_i43.ListMontantPrevisionController>(
      _i43.ListMontantPrevisionController(
    get<_i11.MontantPrevisionGetDataSharedPreferences>(),
    get<_i32.LoadMontantPrevisionUseCase>(),
    get<_i20.SaveMontantprevisionUseCase>(),
    get<_i39.RemoveMontantPrevisionUseCase>(),
    get<_i29.AddMontantPrevisionUseCase>(),
    get<_i41.ResetListMontantPrevisionUseCase>(),
  ));
  gh.singleton<_i44.ListMontantUniverselleController>(
      _i44.ListMontantUniverselleController(
    get<_i12.MontantUniverselleGetDataSharedpreferencies>(),
    get<_i33.LoadMontantUniverselleUseCase>(),
    get<_i19.SaveMontantUniverselleUseCase>(),
    get<_i30.AddMontantUniverselleUseCase>(),
    get<_i40.RemoveMontantUniverselleUseCase>(),
    get<_i25.AddDescriptionMontantUniverselleUseCase>(),
    get<_i34.RemoveDescriptionMontantUniverselleUseCase>(),
  ));
  return get;
}
