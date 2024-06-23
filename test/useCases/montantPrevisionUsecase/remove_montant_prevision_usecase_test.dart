import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/remove_montant_prevision_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';

class MockSaveMontantPrevisionUseCase extends Mock implements SaveMontantprevisionUseCase {}

void main() {
  late MockSaveMontantPrevisionUseCase mockSaveMontantPrevisionUseCase;
  late RemoveMontantPrevisionUseCase removeMontantPrevisionUseCase;

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
    removeMontantPrevisionUseCase = RemoveMontantPrevisionUseCase(mockSaveMontantPrevisionUseCase);
  });

  test('Should remove MontantUniverselle from list and save the list', () async {
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
        icones: 0,
      ),
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id2',
        montant: 200.0,
        nom: 'nom2',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 0,
      ),
    ];

    when(() => mockSaveMontantPrevisionUseCase.execute(any(), remove: any(named: 'remove'))).thenAnswer((_) async => true);

    // Act
    await removeMontantPrevisionUseCase.execute(
      index: 0,
      listMontantPrevision: listMontantPrevision,
    );

    // Assert
    expect(listMontantPrevision.length, 1);
    expect(listMontantPrevision[0].id, 'id2');
    verify(() => mockSaveMontantPrevisionUseCase.execute(listMontantPrevision, remove: true)).called(1);
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
        icones: 0,
      ),
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id2',
        montant: 200.0,
        nom: 'nom2',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 0,
      ),
    ];

    when(() => mockSaveMontantPrevisionUseCase.execute(any(), remove: any(named: 'remove'))).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await removeMontantPrevisionUseCase.execute(
        index: 0,
        listMontantPrevision: listMontantPrevision,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
