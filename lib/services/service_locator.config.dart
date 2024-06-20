// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../controllers/list_gestion_mensuel_controller.dart' as _i59;
import '../controllers/list_montant_prevision_controller.dart' as _i60;
import '../controllers/list_montant_universelle_controller.dart' as _i62;
import '../mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart'
    as _i11;
import '../useCases/choix_desciption_details_finance_enum_usecase.dart' as _i5;
import '../useCases/choix_desciption_upload_usecase.dart' as _i7;
import '../useCases/choix_description_enum_usecase.dart' as _i6;
import '../useCases/generate_gestion_mensuel_prevision_usecase.dart' as _i8;
import '../useCases/gestionMensuelUsecase/add_achat_total_usecase.dart' as _i28;
import '../useCases/gestionMensuelUsecase/add_description_gestion_usecase.dart'
    as _i29;
import '../useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_live_usecase.dart'
    as _i31;
import '../useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_usecase.dart'
    as _i32;
import '../useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart'
    as _i33;
import '../useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart'
    as _i3;
import '../useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart'
    as _i4;
import '../useCases/gestionMensuelUsecase/change_icons_gestion_mensuel_usecase.dart'
    as _i36;
import '../useCases/gestionMensuelUsecase/change_prix_gestion_mensuel_usecase.dart'
    as _i39;
import '../useCases/gestionMensuelUsecase/change_titre_gestion_mensuel_usecase.dart'
    as _i42;
import '../useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart'
    as _i46;
import '../useCases/gestionMensuelUsecase/remove_gestion_description_gestion_usecase.dart'
    as _i50;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart'
    as _i51;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_live_usecase.dart'
    as _i52;
import '../useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_usecase.dart'
    as _i53;
import '../useCases/gestionMensuelUsecase/save_description_gestion_usecase.dart'
    as _i15;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart'
    as _i17;
import '../useCases/gestionMensuelUsecase/save_gestion_mensuelle_montant_univ_usecase.dart'
    as _i18;
import '../useCases/gestionMensuelUsecase/toggle_active_gestion_mensuel_usecase.dart'
    as _i23;
import '../useCases/gestionMensuelUsecase/update_montant_achat_usecase.dart'
    as _i26;
import '../useCases/gestionMensuelUsecase/update_montant_prevision_usecase.dart'
    as _i27;
import '../useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart'
    as _i34;
import '../useCases/montantPrevisionUsecase/change_icons_simulation_usecase.dart'
    as _i37;
import '../useCases/montantPrevisionUsecase/change_prix_simulation_usecase.dart'
    as _i40;
import '../useCases/montantPrevisionUsecase/change_titre_simulation_usecase.dart'
    as _i43;
import '../useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart'
    as _i47;
import '../useCases/montantPrevisionUsecase/remove_montant_prevision_usecase.dart'
    as _i54;
import '../useCases/montantPrevisionUsecase/reset_list_montant_prevision_usecase.dart'
    as _i56;
import '../useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart'
    as _i22;
import '../useCases/montantPrevisionUsecase/toggle_active_montant_prevision_usecase.dart'
    as _i24;
import '../useCases/montantUniverselleUsecase/add_description_montant_universelle_usecase.dart'
    as _i30;
import '../useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart'
    as _i35;
import '../useCases/montantUniverselleUsecase/change_icons_usecase.dart'
    as _i38;
import '../useCases/montantUniverselleUsecase/change_prix_usecase.dart' as _i41;
import '../useCases/montantUniverselleUsecase/change_titre_usecase.dart'
    as _i44;
import '../useCases/montantUniverselleUsecase/echeance_no_passe_montan_unive_usecase.dart'
    as _i57;
import '../useCases/montantUniverselleUsecase/echeance_no_passe_montan_unive_valid_usecase.dart'
    as _i45;
import '../useCases/montantUniverselleUsecase/echeance_passe_montan_unive_usecase.dart'
    as _i61;
import '../useCases/montantUniverselleUsecase/echeance_passe_montan_unive_valid_usecase.dart'
    as _i58;
import '../useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart'
    as _i48;
import '../useCases/montantUniverselleUsecase/remove_description_montant_universelle_usecase.dart'
    as _i49;
import '../useCases/montantUniverselleUsecase/remove_montant_universelle_usecase.dart'
    as _i55;
import '../useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart'
    as _i21;
import '../useCases/montantUniverselleUsecase/toggle_active_montant_universelle_usecase.dart'
    as _i25;
import '../useCases/read_content_usecase.dart' as _i14;
import 'gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart'
    as _i9;
import 'gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart'
    as _i16;
import 'montantPrevision/montant_prevision_get_data_sharedpreferencies.dart'
    as _i12;
import 'montantPrevision/save_montant_prevision_sharedpreferencies.dart'
    as _i19;
import 'montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart'
    as _i13;
import 'montantUniverselleServices/save_montant_universelle_sharedpreferencies.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.ChoixDesciptionUploadUseCase>(
      () => _i7.ChoixDesciptionUploadUseCase());
  gh.factory<_i8.GenerateGestionMensuelPrevisionUseCase>(
      () => _i8.GenerateGestionMensuelPrevisionUseCase());
  gh.singleton<_i9.GestionMensuelGetDataSharedpreferencies>(
      _i9.GestionMensuelGetDataSharedpreferencies(
          get<_i10.SharedPreferences>()));
  gh.singleton<_i11.MapperListGestionMensuelJsonToModelUseCase>(
      _i11.MapperListGestionMensuelJsonToModelUseCase());
  gh.factory<_i12.MontantPrevisionGetDataSharedPreferences>(() =>
      _i12.MontantPrevisionGetDataSharedPreferences(
          get<_i10.SharedPreferences>()));
  gh.singleton<_i13.MontantUniverselleGetDataSharedpreferencies>(
      _i13.MontantUniverselleGetDataSharedpreferencies(
          get<_i10.SharedPreferences>()));
  gh.factory<_i14.ReadContentUseCase>(() => _i14.ReadContentUseCase());
  gh.factory<_i15.SaveDescriptionGestionUseCase>(
      () => _i15.SaveDescriptionGestionUseCase(get<_i10.SharedPreferences>()));
  gh.singleton<_i16.SaveGestionMensuelSharedPreferencesService>(
      _i16.SaveGestionMensuelSharedPreferencesService(
          get<_i10.SharedPreferences>()));
  gh.singleton<_i17.SaveGestionMensuelUseCase>(_i17.SaveGestionMensuelUseCase(
      get<_i16.SaveGestionMensuelSharedPreferencesService>()));
  gh.factory<_i18.SaveGestionMensuelleMontantUnivUseCase>(() =>
      _i18.SaveGestionMensuelleMontantUnivUseCase(
          get<_i10.SharedPreferences>()));
  gh.factory<_i19.SaveMontantPrevisionSharedPreferencesService>(() =>
      _i19.SaveMontantPrevisionSharedPreferencesService(
          get<_i10.SharedPreferences>()));
  gh.singleton<_i20.SaveMontantUniverselleSharedPreferencesService>(
      _i20.SaveMontantUniverselleSharedPreferencesService(
          get<_i10.SharedPreferences>()));
  gh.singleton<_i21.SaveMontantUniverselleUseCase>(
      _i21.SaveMontantUniverselleUseCase(
          get<_i20.SaveMontantUniverselleSharedPreferencesService>()));
  gh.singleton<_i22.SaveMontantprevisionUseCase>(
      _i22.SaveMontantprevisionUseCase(
          get<_i19.SaveMontantPrevisionSharedPreferencesService>()));
  gh.factory<_i23.ToggleActiveGestionMensuelUseCase>(() =>
      _i23.ToggleActiveGestionMensuelUseCase(
          get<_i17.SaveGestionMensuelUseCase>()));
  gh.factory<_i24.ToggleActiveMontantPrevisionUseCase>(() =>
      _i24.ToggleActiveMontantPrevisionUseCase(
          get<_i22.SaveMontantprevisionUseCase>()));
  gh.factory<_i25.ToggleActiveMontantUniverselleUseCase>(() =>
      _i25.ToggleActiveMontantUniverselleUseCase(
          get<_i21.SaveMontantUniverselleUseCase>()));
  gh.factory<_i26.UpdateMontantAchatUseCase>(
      () => _i26.UpdateMontantAchatUseCase(
            get<_i3.CalculateTotalAchatUseCase>(),
            get<_i17.SaveGestionMensuelUseCase>(),
          ));
  gh.factory<_i27.UpdateMontantPrevisionUseCase>(
      () => _i27.UpdateMontantPrevisionUseCase(
            get<_i4.CalculateTotalPrevisionUseCase>(),
            get<_i17.SaveGestionMensuelUseCase>(),
          ));
  gh.factory<_i28.AddAchatTotalUseCase>(
      () => _i28.AddAchatTotalUseCase(get<_i17.SaveGestionMensuelUseCase>()));
  gh.factory<_i29.AddDescriptionGestionUseCase>(
      () => _i29.AddDescriptionGestionUseCase(
            get<_i17.SaveGestionMensuelUseCase>(),
            get<_i6.ChoixDesciptionEnumUseCase>(),
          ));
  gh.factory<_i30.AddDescriptionMontantUniverselleUseCase>(
      () => _i30.AddDescriptionMontantUniverselleUseCase(
            get<_i6.ChoixDesciptionEnumUseCase>(),
            get<_i21.SaveMontantUniverselleUseCase>(),
          ));
  gh.factory<_i31.AddGestionMensuelMontantUnivLiveUseCase>(
      () => _i31.AddGestionMensuelMontantUnivLiveUseCase(
            get<_i17.SaveGestionMensuelUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i32.AddGestionMensuelMontantUnivUseCase>(
      () => _i32.AddGestionMensuelMontantUnivUseCase(
            get<_i17.SaveGestionMensuelUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i33.AddMontantGestionUseCase>(() => _i33.AddMontantGestionUseCase(
        get<_i17.SaveGestionMensuelUseCase>(),
        get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
      ));
  gh.factory<_i34.AddMontantPrevisionUseCase>(
      () => _i34.AddMontantPrevisionUseCase(
            get<_i22.SaveMontantprevisionUseCase>(),
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
          ));
  gh.factory<_i35.AddMontantUniverselleUseCase>(
      () => _i35.AddMontantUniverselleUseCase(
            get<_i5.ChoixDesciptionDetailsFinanceEnumUseCase>(),
            get<_i33.AddMontantGestionUseCase>(),
            get<_i21.SaveMontantUniverselleUseCase>(),
          ));
  gh.factory<_i36.ChangeIconsGestionMensuelUseCase>(() =>
      _i36.ChangeIconsGestionMensuelUseCase(
          get<_i17.SaveGestionMensuelUseCase>()));
  gh.factory<_i37.ChangeIconsSimulationUseCase>(() =>
      _i37.ChangeIconsSimulationUseCase(
          get<_i22.SaveMontantprevisionUseCase>()));
  gh.factory<_i38.ChangeIconsUseCase>(
      () => _i38.ChangeIconsUseCase(get<_i21.SaveMontantUniverselleUseCase>()));
  gh.factory<_i39.ChangePrixGestionMensuelUseCase>(() =>
      _i39.ChangePrixGestionMensuelUseCase(
          get<_i17.SaveGestionMensuelUseCase>()));
  gh.factory<_i40.ChangePrixSimulationUseCase>(() =>
      _i40.ChangePrixSimulationUseCase(
          get<_i22.SaveMontantprevisionUseCase>()));
  gh.factory<_i41.ChangePrixUseCase>(
      () => _i41.ChangePrixUseCase(get<_i21.SaveMontantUniverselleUseCase>()));
  gh.factory<_i42.ChangeTitreGestionMensuelUseCase>(() =>
      _i42.ChangeTitreGestionMensuelUseCase(
          get<_i17.SaveGestionMensuelUseCase>()));
  gh.factory<_i43.ChangeTitreSimulationUseCase>(() =>
      _i43.ChangeTitreSimulationUseCase(
          get<_i22.SaveMontantprevisionUseCase>()));
  gh.factory<_i44.ChangeTitreUseCase>(
      () => _i44.ChangeTitreUseCase(get<_i21.SaveMontantUniverselleUseCase>()));
  gh.factory<_i45.EcheanceNoPasseMontanUniveValidUseCase>(() =>
      _i45.EcheanceNoPasseMontanUniveValidUseCase(
          get<_i21.SaveMontantUniverselleUseCase>()));
  gh.singleton<_i46.LoadGestionMensuelUseCase>(_i46.LoadGestionMensuelUseCase(
      get<_i11.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i47.LoadMontantPrevisionUseCase>(
      _i47.LoadMontantPrevisionUseCase(
          get<_i11.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.singleton<_i48.LoadMontantUniverselleUseCase>(
      _i48.LoadMontantUniverselleUseCase(
          get<_i11.MapperListGestionMensuelJsonToModelUseCase>()));
  gh.factory<_i49.RemoveDescriptionMontantUniverselleUseCase>(() =>
      _i49.RemoveDescriptionMontantUniverselleUseCase(
          get<_i21.SaveMontantUniverselleUseCase>()));
  gh.factory<_i50.RemoveGestionDescriptionGestionUseCase>(() =>
      _i50.RemoveGestionDescriptionGestionUseCase(
          get<_i15.SaveDescriptionGestionUseCase>()));
  gh.factory<_i51.RemoveGestionMensuelUseCase>(() =>
      _i51.RemoveGestionMensuelUseCase(get<_i17.SaveGestionMensuelUseCase>()));
  gh.factory<_i52.RemoveGestionMensuelleMontantUnivLiveUseCase>(() =>
      _i52.RemoveGestionMensuelleMontantUnivLiveUseCase(
          get<_i17.SaveGestionMensuelUseCase>()));
  gh.factory<_i53.RemoveGestionMensuelleMontantUnivUseCase>(() =>
      _i53.RemoveGestionMensuelleMontantUnivUseCase(
          get<_i18.SaveGestionMensuelleMontantUnivUseCase>()));
  gh.factory<_i54.RemoveMontantPrevisionUseCase>(() =>
      _i54.RemoveMontantPrevisionUseCase(
          get<_i22.SaveMontantprevisionUseCase>()));
  gh.factory<_i55.RemoveMontantUniverselleUseCase>(() =>
      _i55.RemoveMontantUniverselleUseCase(
          get<_i21.SaveMontantUniverselleUseCase>()));
  gh.factory<_i56.ResetListMontantPrevisionUseCase>(() =>
      _i56.ResetListMontantPrevisionUseCase(
          get<_i22.SaveMontantprevisionUseCase>()));
  gh.factory<_i57.EcheanceNoPasseMontanUniveUseCase>(() =>
      _i57.EcheanceNoPasseMontanUniveUseCase(
          get<_i45.EcheanceNoPasseMontanUniveValidUseCase>()));
  gh.factory<_i58.EcheancePasseMontanUniveValidUseCase>(
      () => _i58.EcheancePasseMontanUniveValidUseCase(
            get<_i55.RemoveMontantUniverselleUseCase>(),
            get<_i21.SaveMontantUniverselleUseCase>(),
          ));
  gh.singleton<_i59.ListGestionMensuelController>(
      _i59.ListGestionMensuelController(
    get<_i9.GestionMensuelGetDataSharedpreferencies>(),
    get<_i11.MapperListGestionMensuelJsonToModelUseCase>(),
    get<_i46.LoadGestionMensuelUseCase>(),
    get<_i17.SaveGestionMensuelUseCase>(),
    get<_i33.AddMontantGestionUseCase>(),
    get<_i51.RemoveGestionMensuelUseCase>(),
    get<_i4.CalculateTotalPrevisionUseCase>(),
    get<_i3.CalculateTotalAchatUseCase>(),
    get<_i27.UpdateMontantPrevisionUseCase>(),
    get<_i26.UpdateMontantAchatUseCase>(),
    get<_i28.AddAchatTotalUseCase>(),
    get<_i29.AddDescriptionGestionUseCase>(),
    get<_i32.AddGestionMensuelMontantUnivUseCase>(),
    get<_i31.AddGestionMensuelMontantUnivLiveUseCase>(),
    get<_i52.RemoveGestionMensuelleMontantUnivLiveUseCase>(),
    get<_i15.SaveDescriptionGestionUseCase>(),
    get<_i18.SaveGestionMensuelleMontantUnivUseCase>(),
    get<_i50.RemoveGestionDescriptionGestionUseCase>(),
    get<_i53.RemoveGestionMensuelleMontantUnivUseCase>(),
    get<_i39.ChangePrixGestionMensuelUseCase>(),
    get<_i42.ChangeTitreGestionMensuelUseCase>(),
    get<_i36.ChangeIconsGestionMensuelUseCase>(),
    get<_i23.ToggleActiveGestionMensuelUseCase>(),
  ));
  gh.singleton<_i60.ListMontantPrevisionController>(
      _i60.ListMontantPrevisionController(
    get<_i12.MontantPrevisionGetDataSharedPreferences>(),
    get<_i47.LoadMontantPrevisionUseCase>(),
    get<_i22.SaveMontantprevisionUseCase>(),
    get<_i54.RemoveMontantPrevisionUseCase>(),
    get<_i34.AddMontantPrevisionUseCase>(),
    get<_i56.ResetListMontantPrevisionUseCase>(),
    get<_i40.ChangePrixSimulationUseCase>(),
    get<_i43.ChangeTitreSimulationUseCase>(),
    get<_i37.ChangeIconsSimulationUseCase>(),
    get<_i24.ToggleActiveMontantPrevisionUseCase>(),
  ));
  gh.factory<_i61.EcheancePasseMontanUniveUseCase>(() =>
      _i61.EcheancePasseMontanUniveUseCase(
          get<_i58.EcheancePasseMontanUniveValidUseCase>()));
  gh.singleton<_i62.ListMontantUniverselleController>(
      _i62.ListMontantUniverselleController(
    get<_i13.MontantUniverselleGetDataSharedpreferencies>(),
    get<_i48.LoadMontantUniverselleUseCase>(),
    get<_i21.SaveMontantUniverselleUseCase>(),
    get<_i35.AddMontantUniverselleUseCase>(),
    get<_i55.RemoveMontantUniverselleUseCase>(),
    get<_i30.AddDescriptionMontantUniverselleUseCase>(),
    get<_i49.RemoveDescriptionMontantUniverselleUseCase>(),
    get<_i61.EcheancePasseMontanUniveUseCase>(),
    get<_i57.EcheanceNoPasseMontanUniveUseCase>(),
    get<_i41.ChangePrixUseCase>(),
    get<_i44.ChangeTitreUseCase>(),
    get<_i38.ChangeIconsUseCase>(),
    get<_i25.ToggleActiveMontantUniverselleUseCase>(),
  ));
  return get;
}
