import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/add_description_montant_universelle_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/choix_description_enum_usecase.dart';

class MockSaveMontantUniverselleUseCase extends Mock implements SaveMontantUniverselleUseCase {}

class MockChoixDesciptionEnumUseCase extends Mock implements ChoixDesciptionEnumUseCase {}

void main() {
  late MockSaveMontantUniverselleUseCase mockSaveUniverselleUseCase;
  late MockChoixDesciptionEnumUseCase mockChoixDesciptionEnumUseCase;
  late AddDescriptionMontantUniverselleUseCase addDescriptionMontantUniverselleUseCase;

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
      echeance: 0,
      id: 'id',
      name: 'name',
      previsions: 0,
      nombreEcheance: 0,
    ));
  });

  setUp(() {
    mockSaveUniverselleUseCase = MockSaveMontantUniverselleUseCase();
    mockChoixDesciptionEnumUseCase = MockChoixDesciptionEnumUseCase();
    addDescriptionMontantUniverselleUseCase = AddDescriptionMontantUniverselleUseCase(
      mockChoixDesciptionEnumUseCase,
      mockSaveUniverselleUseCase,
    );
  });

  test('Should add description and save the list', () async {
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

    final description = DesciprtionUniverselle(
      adresseImage: 'image.jpg',
      commentaire: 'comment',
      description: unity_description.tache,
      echeance: 2,
      id: 'descId',
      name: 'descName',
      previsions: 100,
      nombreEcheance: 3,
    );

    when(() => mockChoixDesciptionEnumUseCase.execute(any())).thenReturn(unity_description.tache);
    when(() => mockSaveUniverselleUseCase.execute(any(), any())).thenAnswer((_) async => true);

    // Act
    await addDescriptionMontantUniverselleUseCase.execute(
      listMontantUniverselle: listMontantUniverselle,
      achat: [],
      previsions: description.previsions,
      echeance: description.echeance,
      nombreEcheance: description.nombreEcheance,
      id: description.id,
      adresseImage: description.adresseImage,
      name: description.name,
      commentaire: description.commentaire,
      indexChargeFixe: 0,
      description: 'tache',
    );

    // Assert
    expect(listMontantUniverselle[0].descriptionUniverselle.length, 1);
    expect(listMontantUniverselle[0].descriptionUniverselle[0].id, 'descId');
    expect(listMontantUniverselle[0].descriptionUniverselle[0].name, 'descName');
    expect(listMontantUniverselle[0].descriptionUniverselle[0].description, unity_description.tache);
    verify(() => mockSaveUniverselleUseCase.execute(listMontantUniverselle, false)).called(1);
  });

  test('Should handle exception from saveUniverselleUseCase', () async {
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

    when(() => mockChoixDesciptionEnumUseCase.execute(any())).thenReturn(unity_description.tache);
    when(() => mockSaveUniverselleUseCase.execute(any(), any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await addDescriptionMontantUniverselleUseCase.execute(
        listMontantUniverselle: listMontantUniverselle,
        achat: [],
        previsions: 100,
        echeance: 2,
        nombreEcheance: 3,
        id: 'descId',
        adresseImage: 'image.jpg',
        name: 'descName',
        commentaire: 'comment',
        indexChargeFixe: 0,
        description: 'tache',
      ),
      throwsA(isA<Exception>()),
    );
  });
}
