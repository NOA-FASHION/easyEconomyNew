import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/toggle_active_montant_prevision_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';

class MockSaveMontantPrevisionUseCase extends Mock implements SaveMontantprevisionUseCase {}

void main() {
  late MockSaveMontantPrevisionUseCase mockSaveMontantPrevisionUseCase;
  late ToggleActiveMontantPrevisionUseCase toggleActiveMontantPrevisionUseCase;

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
    mockSaveMontantPrevisionUseCase = MockSaveMontantPrevisionUseCase();
    toggleActiveMontantPrevisionUseCase = ToggleActiveMontantPrevisionUseCase(mockSaveMontantPrevisionUseCase);
  });

  test('Should toggle previsionsTotal from 0 to 1 and save the list', () async {
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

    when(() => mockSaveMontantPrevisionUseCase.execute(any())).thenAnswer((_) async => true);

    // Act
    await toggleActiveMontantPrevisionUseCase.execute(
      index: 0,
      listMontantPrevision: listMontantPrevision,
    );

    // Assert
    expect(listMontantPrevision[0].previsionsTotal, 1);
    verify(() => mockSaveMontantPrevisionUseCase.execute(listMontantPrevision)).called(1);
  });

  test('Should toggle previsionsTotal from 1 to 0 and save the list', () async {
    // Arrange
    final List<MontantUniverselle> listMontantPrevision = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id1',
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 1,
        icones: 1,
      ),
    ];

    when(() => mockSaveMontantPrevisionUseCase.execute(any())).thenAnswer((_) async => true);

    // Act
    await toggleActiveMontantPrevisionUseCase.execute(
      index: 0,
      listMontantPrevision: listMontantPrevision,
    );

    // Assert
    expect(listMontantPrevision[0].previsionsTotal, 0);
    verify(() => mockSaveMontantPrevisionUseCase.execute(listMontantPrevision)).called(1);
  });

  test('Should handle exception from saveMontantPrevisionUseCase', () async {
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

    when(() => mockSaveMontantPrevisionUseCase.execute(any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await toggleActiveMontantPrevisionUseCase.execute(
        index: 0,
        listMontantPrevision: listMontantPrevision,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
