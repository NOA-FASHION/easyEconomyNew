// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../controllers/list_gestion_mensuel_controller.dart' as _i57;
import '../controllers/list_montant_prevision_controller.dart' as _i58;
import '../controllers/list_montant_universelle_controller.dart' as _i60;
import '../mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart'
    as _i10;
import '../useCases/choix_desciption_details_finance_enum_usecase.dart' as _i5;
import '../useCases/choix_description_enum_usecase.dart' as _i6;
import '../useCases/generate_gestion_mensuel_prevision_usecase.dart' as _i7;
import '../useCases/gestionMensuelUsecase/add_achat_total_usecase.dart' as _i26;
import '../useCases/gestionMensuelUsecase/add_description_gestion_usecase.dart'
    as _i27;
import '../useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_live_usecase.dart'
    as _i29;
import '../useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_usecase.dart'
    as _i30;
import '../useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart'
    as _i31;
import '../useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart'
    as _i3;
import '../useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart'
    as _i4;
import '../useCases/gestionMensuelUsecase/change_icons_gestion_mensuel_usecase.dart'
    as _i34;
import '../useCases/gestionMensuelUsecase/change_prix_gestion_mensuel_usecase.dart'
    as _i37;
import '../useCases/gestionMensuelUsecase/change_titre_gestion_mensuel_usecase.dart'
    as _i40;
import '../useCases/gestionMensuelUsecase/gestionMensuelUsecase/toggle_active_gestion_mensuel_usecase.dart'
    as _i21;
import '../useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart'
    as _i44;
import '../useCases/gestionMensuelUsecase/remove_gestion_description_gestion_usecase.dart'
    as _i48;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart'
    as _i49;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_live_usecase.dart'
    as _i50;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_usecase.dart'
    as _i51;
import '../useCases/gestionMensuelUsecase/save_description_gestion_usecase.dart'
    as _i13;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart'
    as _i15;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuelle_montant_univ_usecase.dart'
    as _i16;
import '../useCases/gestionMensuelUsecase/update_montant_achat_usecase.dart'
    as _i24;
import '../useCases/gestionMensuelUsecase/update_montant_prevision_usecase.dart'
    as _i25;
import '../useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart'
    as _i32;
import '../useCases/montantPrevisionUsecase/change_icons_simulation_usecase.dart'
    as _i35;
import '../useCases/montantPrevisionUsecase/change_prix_simulation_usecase.dart'
    as _i38;
import '../useCases/montantPrevisionUsecase/change_titre_simulation_usecase.dart'
    as _i41;
import '../useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart'
    as _i45;
import '../useCases/montantPrevisionUsecase/remove_montant_prevision_usecase.dart'
    as _i52;
import '../useCases/montantPrevisionUsecase/reset_list_montant_prevision_usecase.dart'
    as _i54;
import '../useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart'
    as _i20;
import '../useCases/montantPrevisionUsecase/toggle_active_montant_prevision_usecase.dart'
    as _i22;
import '../useCases/montantUniverselleUsecase/add_description_montant_universelle_usecase.dart'
    as _i28;
import '../useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart'
    as _i33;
import '../useCases/montantUniverselleUsecase/change_icons_usecase.dart'
    as _i36;
import '../useCases/montantUniverselleUsecase/change_prix_usecase.dart' as _i39;
import '../useCases/montantUniverselleUsecase/change_titre_usecase.dart'
    as _i42;
import '../useCases/montantUniverselleUsecase/echeance_no_passe_montan_unive_usecase.dart'
    as _i55;
import '../useCases/montantUniverselleUsecase/echeance_no_passe_montan_unive_valid_usecase.dart'
    as _i43;
import '../useCases/montantUniverselleUsecase/echeance_passe_montan_unive_usecase.dart'
    as _i59;
import '../useCases/montantUniverselleUsecase/echeance_passe_montan_unive_valid_usecase.dart'
    as _i56;
import '../useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart'
    as _i46;
import '../useCases/montantUniverselleUsecase/remove_description_montant_universelle_usecase.dart'
    as _i47;
import '../useCases/montantUniverselleUsecase/remove_montant_universelle_usecase.dart'
    as _i53;
import '../useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart'
    as _i19;
import '../useCases/montantUniverselleUsecase/toggle_active_montant_universelle_usecase.dart'
    as _i23;
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
  gh.factory<_i21.ToggleActiveGestionMensuelUseCase>(() =>
      _i21.ToggleActiveGestionMensuelUseCase(
          get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i22.ToggleActiveMontantPrevisionUseCase>(() =>
      _i22.ToggleActiveMontantPrevisionUseCase(
          get<_i20.SaveMontantprevisionUseCase>()));
  gh.factory<_i23.ToggleActiveMontantUniverselleUseCase>(() =>
      _i23.ToggleActiveMontantUniverselleUseCase(
          get<_i19.SaveMontantUniverselleUseCase>()));
  gh.factory<_i24.UpdateMontantAchatUseCase>(
      () => _i24.UpdateMontantAchatUseCase(
            get<_i3.CalculateTotalAchatUseCase>(),
            get<_i15.SaveGestionMensuelUseCase>(),
          ));
  gh.factory<_i25.UpdateMontantPrevisionUseCase>(
      () => _i25.UpdateMontantPrevisionUseCase(
            get<_i4.CalculateTotalPrevisionUseCase>(),
            get<_i15.SaveGestionMensuelUseCase>(),
          ));
  gh.factory<_i26.AddAchatTotalUseCase>(
      () => _i26.AddAchatTotalUseCase(get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i27.AddDescriptionGestionUseCase>(
      () => _i27.AddDescriptionGestionUseCase(
            get<_i15.SaveGestionMensuelUseCase>(),
            get<_i6.ChoixDesciptionEnumUseCase>(),
          ));
  gh.factory<_i28.AddDescriptionMontantUniverselleUseCase>(
      () => _i28.AddDescriptionMontantUniverselleUseCase(
            get<_i6.ChoixDesciptionEnumUseCase>(),
            get<_i19.SaveMontantUniverselleUseCase>(),
          ));
  gh.factory<_i29.AddGestionMensuelMontantUnivLiveUseCase>(
      () => _i29.AddGestionMensuelMontantUnivLiveUseCase(
            get<_i15.SaveGestionMensuelUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i30.AddGestionMensuelMontantUnivUseCase>(
      () => _i30.AddGestionMensuelMontantUnivUseCase(
            get<_i15.SaveGestionMensuelUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i31.AddMontantGestionUseCase>(() => _i31.AddMontantGestionUseCase(
        get<_i15.SaveGestionMensuelUseCase>(),
        get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
      ));
  gh.factory<_i32.AddMontantPrevisionUseCase>(
      () => _i32.AddMontantPrevisionUseCase(
            get<_i20.SaveMontantprevisionUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i33.AddMontantUniverselleUseCase>(
      () => _i33.AddMontantUniverselleUseCase(
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
            get<_i31.AddMontantGestionUseCase>(),
            get<_i19.SaveMontantUniverselleUseCase>(),
          ));
  gh.factory<_i34.ChangeIconsGestionMensuelUseCase>(() =>
      _i34.ChangeIconsGestionMensuelUseCase(
          get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i35.ChangeIconsSimulationUseCase>(() =>
      _i35.ChangeIconsSimulationUseCase(
          get<_i20.SaveMontantprevisionUseCase>()));
  gh.factory<_i36.ChangeIconsUseCase>(
      () => _i36.ChangeIconsUseCase(get<_i19.SaveMontantUniverselleUseCase>()));
  gh.factory<_i37.ChangePrixGestionMensuelUseCase>(() =>
      _i37.ChangePrixGestionMensuelUseCase(
          get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i38.ChangePrixSimulationUseCase>(() =>
      _i38.ChangePrixSimulationUseCase(
          get<_i20.SaveMontantprevisionUseCase>()));
  gh.factory<_i39.ChangePrixUseCase>(
      () => _i39.ChangePrixUseCase(get<_i19.SaveMontantUniverselleUseCase>()));
  gh.factory<_i40.ChangeTitreGestionMensuelUseCase>(() =>
      _i40.ChangeTitreGestionMensuelUseCase(
          get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i41.ChangeTitreSimulationUseCase>(() =>
      _i41.ChangeTitreSimulationUseCase(
          get<_i20.SaveMontantprevisionUseCase>()));
  gh.factory<_i42.ChangeTitreUseCase>(
      () => _i42.ChangeTitreUseCase(get<_i19.SaveMontantUniverselleUseCase>()));
  gh.factory<_i43.EcheanceNoPasseMontanUniveValidUseCase>(() =>
      _i43.EcheanceNoPasseMontanUniveValidUseCase(
          get<_i19.SaveMontantUniverselleUseCase>()));
  gh.singleton<_i44.LoadGestionMensuelUseCase>(_i44.LoadGestionMensuelUseCase(
      get<_i10.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i45.LoadMontantPrevisionUseCase>(
      _i45.LoadMontantPrevisionUseCase(
          get<_i10.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i46.LoadMontantUniverselleUseCase>(
      _i46.LoadMontantUniverselleUseCase(
          get<_i10.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.factory<_i47.RemoveDescriptionMontantUniverselleUseCase>(() =>
      _i47.RemoveDescriptionMontantUniverselleUseCase(
          get<_i19.SaveMontantUniverselleUseCase>()));
  gh.factory<_i48.RemoveGestionDescriptionGestionUseCase>(() =>
      _i48.RemoveGestionDescriptionGestionUseCase(
          get<_i13.SaveDescriptionGestionUseCase>()));
  gh.factory<_i49.RemoveGestionMensuelUseCase>(() =>
      _i49.RemoveGestionMensuelUseCase(get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i50.RemoveGestionMensuelleMontantUnivLiveUseCase>(() =>
      _i50.RemoveGestionMensuelleMontantUnivLiveUseCase(
          get<_i15.SaveGestionMensuelUseCase>()));
  gh.factory<_i51.RemoveGestionMensuelleMontantUnivUseCase>(() =>
      _i51.RemoveGestionMensuelleMontantUnivUseCase(
          get<_i16.SaveGestionMensuelleMontantUnivUseCase>()));
  gh.factory<_i52.RemoveMontantPrevisionUseCase>(() =>
      _i52.RemoveMontantPrevisionUseCase(
          get<_i20.SaveMontantprevisionUseCase>()));
  gh.factory<_i53.RemoveMontantUniverselleUseCase>(() =>
      _i53.RemoveMontantUniverselleUseCase(
          get<_i19.SaveMontantUniverselleUseCase>()));
  gh.factory<_i54.ResetListMontantPrevisionUseCase>(() =>
      _i54.ResetListMontantPrevisionUseCase(
          get<_i20.SaveMontantprevisionUseCase>()));
  gh.factory<_i55.EcheanceNoPasseMontanUniveUseCase>(() =>
      _i55.EcheanceNoPasseMontanUniveUseCase(
          get<_i43.EcheanceNoPasseMontanUniveValidUseCase>()));
  gh.factory<_i56.EcheancePasseMontanUniveValidUseCase>(
      () => _i56.EcheancePasseMontanUniveValidUseCase(
            get<_i53.RemoveMontantUniverselleUseCase>(),
            get<_i19.SaveMontantUniverselleUseCase>(),
          ));
  gh.singleton<_i57.ListGestionMensuelController>(
      _i57.ListGestionMensuelController(
    get<_i8.GestionMensuelGetDataSharedpreferencies>(),
    get<_i10.MapperListGestionMensuelJsonToModelUseCase>(),
    get<_i44.LoadGestionMensuelUseCase>(),
    get<_i15.SaveGestionMensuelUseCase>(),
    get<_i31.AddMontantGestionUseCase>(),
    get<_i49.RemoveGestionMensuelUseCase>(),
    get<_i4.CalculateTotalPrevisionUseCase>(),
    get<_i3.CalculateTotalAchatUseCase>(),
    get<_i25.UpdateMontantPrevisionUseCase>(),
    get<_i24.UpdateMontantAchatUseCase>(),
    get<_i26.AddAchatTotalUseCase>(),
    get<_i27.AddDescriptionGestionUseCase>(),
    get<_i30.AddGestionMensuelMontantUnivUseCase>(),
    get<_i29.AddGestionMensuelMontantUnivLiveUseCase>(),
    get<_i50.RemoveGestionMensuelleMontantUnivLiveUseCase>(),
    get<_i13.SaveDescriptionGestionUseCase>(),
    get<_i16.SaveGestionMensuelleMontantUnivUseCase>(),
    get<_i48.RemoveGestionDescriptionGestionUseCase>(),
    get<_i51.RemoveGestionMensuelleMontantUnivUseCase>(),
    get<_i37.ChangePrixGestionMensuelUseCase>(),
    get<_i40.ChangeTitreGestionMensuelUseCase>(),
    get<_i34.ChangeIconsGestionMensuelUseCase>(),
    get<_i21.ToggleActiveGestionMensuelUseCase>(),
  ));
  gh.singleton<_i58.ListMontantPrevisionController>(
      _i58.ListMontantPrevisionController(
    get<_i11.MontantPrevisionGetDataSharedPreferences>(),
    get<_i45.LoadMontantPrevisionUseCase>(),
    get<_i20.SaveMontantprevisionUseCase>(),
    get<_i52.RemoveMontantPrevisionUseCase>(),
    get<_i32.AddMontantPrevisionUseCase>(),
    get<_i54.ResetListMontantPrevisionUseCase>(),
    get<_i38.ChangePrixSimulationUseCase>(),
    get<_i41.ChangeTitreSimulationUseCase>(),
    get<_i35.ChangeIconsSimulationUseCase>(),
    get<_i22.ToggleActiveMontantPrevisionUseCase>(),
  ));
  gh.factory<_i59.EcheancePasseMontanUniveUseCase>(() =>
      _i59.EcheancePasseMontanUniveUseCase(
          get<_i56.EcheancePasseMontanUniveValidUseCase>()));
  gh.singleton<_i60.ListMontantUniverselleController>(
      _i60.ListMontantUniverselleController(
    get<_i12.MontantUniverselleGetDataSharedpreferencies>(),
    get<_i46.LoadMontantUniverselleUseCase>(),
    get<_i19.SaveMontantUniverselleUseCase>(),
    get<_i33.AddMontantUniverselleUseCase>(),
    get<_i53.RemoveMontantUniverselleUseCase>(),
    get<_i28.AddDescriptionMontantUniverselleUseCase>(),
    get<_i47.RemoveDescriptionMontantUniverselleUseCase>(),
    get<_i59.EcheancePasseMontanUniveUseCase>(),
    get<_i55.EcheanceNoPasseMontanUniveUseCase>(),
    get<_i39.ChangePrixUseCase>(),
    get<_i42.ChangeTitreUseCase>(),
    get<_i36.ChangeIconsUseCase>(),
    get<_i23.ToggleActiveMontantUniverselleUseCase>(),
  ));
  return get;
}
