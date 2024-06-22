import 'dart:convert';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuelle_montant_univ_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late SaveGestionMensuelleMontantUnivUseCase saveGestionMensuelleMontantUnivUseCase;

  setUpAll(() {
    registerFallbackValue(GestionMensuel(
      idGestion: 'idGestion',
      nom: 'nom',
      mois: 'mois',
      tendance: 'tendance',
      montantUniverselle: [],
      montantUniverselleLive: [],
    ));
    registerFallbackValue(MontantUniverselle(
     unity: unity_Montant_universelle.ChargeFixe,
      id: 'id',
      montant: 0,
      nom: 'nom',
      descriptionUniverselle: [],
      achat: [],
      previsionsTotal: 0,
      icones: 0,
    ));
  });

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    saveGestionMensuelleMontantUnivUseCase = SaveGestionMensuelleMontantUnivUseCase(mockSharedPreferences);
  });

  test('Should save data and return true when gestion with id is found', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [
          MontantUniverselle(
            unity: unity_Montant_universelle.ChargeFixe,
            id: 'id1',
            montant: 100,
            nom: 'nom1',
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSharedPreferences.setStringList(any(), any())).thenAnswer((_) async => true);

    // Act
    final result = await saveGestionMensuelleMontantUnivUseCase.execute(
      remove: false,
      idGestionMensMontanUniv: '1',
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(result, true);
    verify(() => mockSharedPreferences.setStringList(any(), any())).called(1);
  });

  test('Should handle removal and save empty list when gestion with id has no montantUniverselle and remove is true', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSharedPreferences.setStringList(any(), any())).thenAnswer((_) async => true);

    // Act
    final result = await saveGestionMensuelleMontantUnivUseCase.execute(
      remove: true,
      idGestionMensMontanUniv: '1',
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(result, true);
    expect(listGestionMensuel[0].montantUniverselle.isEmpty, true);
    verify(() => mockSharedPreferences.setStringList(any(), any())).called(1);
  });

  test('Should return false when gestion with id is not found', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '2',
        nom: 'Gestion2',
        mois: 'Feb',
        tendance: 'increasing',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
    ];

    // Act
    final result = await saveGestionMensuelleMontantUnivUseCase.execute(
      remove: false,
      idGestionMensMontanUniv: '1',
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(result, false);
    verifyNever(() => mockSharedPreferences.setStringList(any(), any()));
  });

  test('Should handle exception from SharedPreferences', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [
          MontantUniverselle(
            unity: unity_Montant_universelle.ChargeFixe,
            id: 'id1',
            montant: 100,
            nom: 'nom1',
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSharedPreferences.setStringList(any(), any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await saveGestionMensuelleMontantUnivUseCase.execute(
        remove: false,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
