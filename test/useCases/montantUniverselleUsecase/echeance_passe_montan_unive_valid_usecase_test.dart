import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/echeance_passe_montan_unive_valid_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/remove_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockRemoveMontantUniverselleUseCase extends Mock implements RemoveMontantUniverselleUseCase {}
class MockSaveMontantUniverselleUseCase extends Mock implements SaveMontantUniverselleUseCase {}

void main() {
  late MockRemoveMontantUniverselleUseCase mockRemoveMontantUniverselleUseCase;
  late MockSaveMontantUniverselleUseCase mockSaveMontantUniverselleUseCase;
  late EcheancePasseMontanUniveValidUseCase echeancePasseMontanUniveValidUseCase;

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
    registerFallbackValue(DesciprtionUniverselle(
      adresseImage: '',
      commentaire: '',
      description: unity_description.tache,
      echeance: 1,
      id: 'descId',
      name: 'descName',
      previsions: 0,
      nombreEcheance: 0,
    ));
  });

  setUp(() {
    mockRemoveMontantUniverselleUseCase = MockRemoveMontantUniverselleUseCase();
    mockSaveMontantUniverselleUseCase = MockSaveMontantUniverselleUseCase();
    echeancePasseMontanUniveValidUseCase = EcheancePasseMontanUniveValidUseCase(mockRemoveMontantUniverselleUseCase, mockSaveMontantUniverselleUseCase);
  });

  test('Should decrement nombreEcheance, call removeMontantUniverselleUseCase when nombreEcheance is 0, and save the list', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
      MontantUniverselle(
       unity: unity_Montant_universelle.ChargeFixe,
        id: 'id1',
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [
          DesciprtionUniverselle(
            adresseImage: 'image.jpg',
            commentaire: 'comment',
            description: unity_description.tache,
            echeance: 1,
            id: 'descId1',
            name: 'descName1',
            previsions: 0,
            nombreEcheance: 1,
          ),
          DesciprtionUniverselle(
            adresseImage: 'image2.jpg',
            commentaire: 'comment2',
            description: unity_description.tache,
            echeance: 0,
            id: 'descId2',
            name: 'descName2',
            previsions: 0,
            nombreEcheance: 0,
          ),
        ],
        achat: [],
        previsionsTotal: 0,
        icones: 1,
      ),
    ];

    when(() => mockRemoveMontantUniverselleUseCase.execute(
      index: any(named: 'index'),
      listMontantUniverselle: any(named: 'listMontantUniverselle')
    )).thenAnswer((_) async => true);
    
    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenAnswer((_) async => true);

    // Act
    await echeancePasseMontanUniveValidUseCase.execute(
      index: 0,
      listMontantUniverselle: listMontantUniverselle,
    );

    // Assert
    expect(listMontantUniverselle[0].descriptionUniverselle[0].nombreEcheance, 0);
    expect(listMontantUniverselle[0].descriptionUniverselle[1].nombreEcheance, 0);
    verify(() => mockRemoveMontantUniverselleUseCase.execute(
      index: 0, 
      listMontantUniverselle: listMontantUniverselle
    )).called(2);
    verify(() => mockSaveMontantUniverselleUseCase.execute(listMontantUniverselle, false)).called(1);
  });

  test('Should handle exception from removeMontantUniverselleUseCase', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id1',
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [
          DesciprtionUniverselle(
            adresseImage: 'image.jpg',
            commentaire: 'comment',
            description: unity_description.tache,
            echeance: 1,
            id: 'descId1',
            name: 'descName1',
            previsions: 0,
            nombreEcheance: 1,
          ),
        ],
        achat: [],
        previsionsTotal: 0,
        icones: 1,
      ),
    ];

    when(() => mockRemoveMontantUniverselleUseCase.execute(
      index: any(named: 'index'),
      listMontantUniverselle: any(named: 'listMontantUniverselle')
    )).thenThrow(Exception('Remove failed'));
    
    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenAnswer((_) async => true);

    // Act & Assert
    expect(
      () async => await echeancePasseMontanUniveValidUseCase.execute(
        index: 0,
        listMontantUniverselle: listMontantUniverselle,
      ),
      throwsA(isA<Exception>()),
    );
  });

  test('Should handle exception from saveMontantUniverselleUseCase', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id1',
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [
          DesciprtionUniverselle(
            adresseImage: 'image.jpg',
            commentaire: 'comment',
            description: unity_description.tache,
            echeance: 1,
            id: 'descId1',
            name: 'descName1',
            previsions: 0,
            nombreEcheance: 1,
          ),
        ],
        achat: [],
        previsionsTotal: 0,
        icones: 1,
      ),
    ];

    when(() => mockRemoveMontantUniverselleUseCase.execute(
      index: any(named: 'index'),
      listMontantUniverselle: any(named: 'listMontantUniverselle')
    )).thenAnswer((_) async => true);
    
    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await echeancePasseMontanUniveValidUseCase.execute(
        index: 0,
        listMontantUniverselle: listMontantUniverselle,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
