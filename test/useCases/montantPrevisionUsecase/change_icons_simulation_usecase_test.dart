import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/change_icons_simulation_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';

class MockSaveMontantPrevisionUseCase extends Mock implements SaveMontantprevisionUseCase {}

void main() {
  late MockSaveMontantPrevisionUseCase mockSaveMontantPrevisionUseCase;
  late ChangeIconsSimulationUseCase changeIconsSimulationUseCase;

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
    changeIconsSimulationUseCase = ChangeIconsSimulationUseCase(mockSaveMontantPrevisionUseCase);
  });

  test('Should change icons and save the list', () async {
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

    when(() => mockSaveMontantPrevisionUseCase.execute(any())).thenAnswer((_) async => true);

    // Act
    await changeIconsSimulationUseCase.execute(
      icons: 5,
      indexGestion: 0,
      listMontantPrevision: listMontantPrevision,
    );

    // Assert
    expect(listMontantPrevision[0].icones, 5);
    expect(listMontantPrevision[1].icones, 0); // Unchanged since indexGestion is 0
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

    when(() => mockSaveMontantPrevisionUseCase.execute(any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await changeIconsSimulationUseCase.execute(
        icons: 5,
        indexGestion: 0,
        listMontantPrevision: listMontantPrevision,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
