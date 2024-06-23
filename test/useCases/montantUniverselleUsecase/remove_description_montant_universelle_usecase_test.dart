import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/remove_description_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockSaveMontantUniverselleUseCase extends Mock implements SaveMontantUniverselleUseCase {}

void main() {
  late MockSaveMontantUniverselleUseCase mockSaveMontantUniverselleUseCase;
  late RemoveDescriptionMontantUniverselleUseCase removeDescriptionMontantUniverselleUseCase;

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
    mockSaveMontantUniverselleUseCase = MockSaveMontantUniverselleUseCase();
    removeDescriptionMontantUniverselleUseCase = RemoveDescriptionMontantUniverselleUseCase(mockSaveMontantUniverselleUseCase);
  });

  test('Should remove description from MontantUniverselle and save the list', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id1',
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [
          DesciprtionUniverselle(
            adresseImage: 'image1.jpg',
            commentaire: 'comment1',
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
            echeance: 2,
            id: 'descId2',
            name: 'descName2',
            previsions: 0,
            nombreEcheance: 2,
          ),
        ],
        achat: [],
        previsionsTotal: 0,
        icones: 1,
      ),
    ];

    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenAnswer((_) async => true);

    // Act
    await removeDescriptionMontantUniverselleUseCase.execute(
      index: 0,
      indexChargeFixe: 0,
      listMontantUniverselle: listMontantUniverselle,
    );

    // Assert
    expect(listMontantUniverselle[0].descriptionUniverselle.length, 1);
    expect(listMontantUniverselle[0].descriptionUniverselle[0].id, 'descId2');
    verify(() => mockSaveMontantUniverselleUseCase.execute(listMontantUniverselle, true)).called(1);
  });

  test('Should handle exception from saveUseCase', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id1',
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [
          DesciprtionUniverselle(
            adresseImage: 'image1.jpg',
            commentaire: 'comment1',
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

    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await removeDescriptionMontantUniverselleUseCase.execute(
        index: 0,
        indexChargeFixe: 0,
        listMontantUniverselle: listMontantUniverselle,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
