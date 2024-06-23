import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/toggle_active_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockSaveMontantUniverselleUseCase extends Mock implements SaveMontantUniverselleUseCase {}

void main() {
  late MockSaveMontantUniverselleUseCase mockSaveMontantUniverselleUseCase;
  late ToggleActiveMontantUniverselleUseCase toggleActiveMontantUniverselleUseCase;

  setUpAll(() {
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
    mockSaveMontantUniverselleUseCase = MockSaveMontantUniverselleUseCase();
    toggleActiveMontantUniverselleUseCase = ToggleActiveMontantUniverselleUseCase(mockSaveMontantUniverselleUseCase);
  });

  test('Should toggle previsionsTotal and save the list', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
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
        previsionsTotal: 1,
        icones: 2,
      ),
    ];

    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenAnswer((_) async => true);

    // Act
    await toggleActiveMontantUniverselleUseCase.execute(
      index: 0,
      listMontantUniverselle: listMontantUniverselle,
    );

    // Assert
    expect(listMontantUniverselle[0].previsionsTotal, 1);
    verify(() => mockSaveMontantUniverselleUseCase.execute(listMontantUniverselle, false)).called(1);

    // Act
    await toggleActiveMontantUniverselleUseCase.execute(
      index: 1,
      listMontantUniverselle: listMontantUniverselle,
    );

    // Assert
    expect(listMontantUniverselle[1].previsionsTotal, 0);
    verify(() => mockSaveMontantUniverselleUseCase.execute(listMontantUniverselle, false)).called(1);
  });

  test('Should handle exception from saveUseCase', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
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

    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await toggleActiveMontantUniverselleUseCase.execute(
        index: 0,
        listMontantUniverselle: listMontantUniverselle,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
