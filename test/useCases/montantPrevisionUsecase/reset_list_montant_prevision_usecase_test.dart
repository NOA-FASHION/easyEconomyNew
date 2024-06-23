import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/reset_list_montant_prevision_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';

class MockSaveMontantPrevisionUseCase extends Mock
    implements SaveMontantprevisionUseCase {}

void main() {
  late MockSaveMontantPrevisionUseCase mockSaveMontantPrevisionUseCase;
  late ResetListMontantPrevisionUseCase resetListMontantPrevisionUseCase;

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
    resetListMontantPrevisionUseCase =
        ResetListMontantPrevisionUseCase(mockSaveMontantPrevisionUseCase);
  });

  test('Should reset list and save the new list', () async {
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

    final List<MontantUniverselle> listMontantPrevision = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'oldId',
        montant: 50.0,
        nom: 'oldNom',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 0,
      ),
    ];

    when(() => mockSaveMontantPrevisionUseCase.execute(any(),
        remove: any(named: 'remove'))).thenAnswer((_) async => true);

    // Act
    await resetListMontantPrevisionUseCase.execute(
      listMontantUniverselle: listMontantUniverselle,
      listMontantPrevision: listMontantPrevision,
    );

    // Assert
    expect(listMontantPrevision.length, listMontantUniverselle.length);
    for (int i = 0; i < listMontantPrevision.length; i++) {
      expect(listMontantPrevision[i].unity, listMontantUniverselle[i].unity);
      expect(listMontantPrevision[i].id, listMontantUniverselle[i].id);
      expect(
          listMontantPrevision[i].montant, listMontantUniverselle[i].montant);
      expect(listMontantPrevision[i].nom, listMontantUniverselle[i].nom);
      expect(listMontantPrevision[i].descriptionUniverselle,
          listMontantUniverselle[i].descriptionUniverselle);
      expect(listMontantPrevision[i].achat, isEmpty);
      expect(listMontantPrevision[i].previsionsTotal, 0);
      expect(listMontantPrevision[i].icones, listMontantUniverselle[i].icones);
    }
    verify(() => mockSaveMontantPrevisionUseCase.execute(listMontantPrevision,
        remove: true)).called(1);
  });

  test('Should handle exception from saveMontantPrevisionUseCase', () async {
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
        previsionsTotal: 0,
        icones: 2,
      ),
    ];

    final List<MontantUniverselle> listMontantPrevision = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'oldId',
        montant: 50.0,
        nom: 'oldNom',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 0,
      ),
    ];

    when(() => mockSaveMontantPrevisionUseCase.execute(any(),
        remove: any(named: 'remove'))).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await resetListMontantPrevisionUseCase.execute(
        listMontantUniverselle: listMontantUniverselle,
        listMontantPrevision: listMontantPrevision,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
