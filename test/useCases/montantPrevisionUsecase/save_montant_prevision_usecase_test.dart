import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/montantPrevision/save_montant_prevision_sharedpreferencies.dart';

class MockSaveMontantPrevisionSharedPreferencesService extends Mock implements SaveMontantPrevisionSharedPreferencesService {}

void main() {
  late MockSaveMontantPrevisionSharedPreferencesService mockSaveService;
  late SaveMontantprevisionUseCase saveMontantPrevisionUseCase;

  setUpAll(() {
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    mockSaveService = MockSaveMontantPrevisionSharedPreferencesService();
    saveMontantPrevisionUseCase = SaveMontantprevisionUseCase(mockSaveService);
  });

  test('Should save data correctly when list is not empty', () async {
    // Arrange
    final List<MontantUniverselle> listMontantPrevision = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id1',
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 1,
      ),
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id2',
        montant: 200.0,
        nom: 'nom2',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 2,
      ),
    ];

    final List<String> jsonList = listMontantPrevision.map((challenge) => jsonEncode(challenge.toJson())).toList();

    when(() => mockSaveService.saveData(any())).thenAnswer((_) async => true);

    // Act
    final result = await saveMontantPrevisionUseCase.execute(listMontantPrevision);

    // Assert
    expect(result, true);
    verify(() => mockSaveService.saveData(jsonList)).called(1);
  });

  test('Should save empty data when list is empty and remove is true', () async {
    // Arrange
    final List<MontantUniverselle> listMontantPrevision = [];

    when(() => mockSaveService.saveData(any())).thenAnswer((_) async => true);

    // Act
    final result = await saveMontantPrevisionUseCase.execute(listMontantPrevision, remove: true);

    // Assert
    expect(result, true);
    verify(() => mockSaveService.saveData([])).called(1);
  });

  test('Should return false when list is empty and remove is false', () async {
    // Arrange
    final List<MontantUniverselle> listMontantPrevision = [];

    when(() => mockSaveService.saveData(any())).thenAnswer((_) async => false);

    // Act
    final result = await saveMontantPrevisionUseCase.execute(listMontantPrevision, remove: false);

    // Assert
    expect(result, false);
    verifyNever(() => mockSaveService.saveData(any()));
  });

  test('Should handle exception from saveService', () async {
    // Arrange
    final List<MontantUniverselle> listMontantPrevision = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id1',
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 1,
      ),
    ];

    when(() => mockSaveService.saveData(any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await saveMontantPrevisionUseCase.execute(listMontantPrevision),
      throwsA(isA<Exception>()),
    );
  });
}
