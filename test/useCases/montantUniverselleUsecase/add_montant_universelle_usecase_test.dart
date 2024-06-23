import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart';

class MockSaveMontantUniverselleUseCase extends Mock implements SaveMontantUniverselleUseCase {}

class MockChoixDesciptionDetailsFinanceEnumUseCase extends Mock implements ChoixDesciptionDetailsFinanceEnumUseCase {}

class MockAddMontantGestionUseCase extends Mock implements AddMontantGestionUseCase {}

void main() {
  late MockSaveMontantUniverselleUseCase mockSaveMontantUniverselleUseCase;
  late MockChoixDesciptionDetailsFinanceEnumUseCase mockChoixDesciptionDetailsFinanceEnumUseCase;
  late MockAddMontantGestionUseCase mockAddMontantGestionUseCase;
  late AddMontantUniverselleUseCase addMontantUniverselleUseCase;

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
    mockChoixDesciptionDetailsFinanceEnumUseCase = MockChoixDesciptionDetailsFinanceEnumUseCase();
    mockAddMontantGestionUseCase = MockAddMontantGestionUseCase();
    addMontantUniverselleUseCase = AddMontantUniverselleUseCase(
      mockChoixDesciptionDetailsFinanceEnumUseCase,
      mockAddMontantGestionUseCase,
      mockSaveMontantUniverselleUseCase,
    );
  });

  test('Should add MontantUniverselle and save the list', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
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

    final unityDescription = unity_Montant_universelle.ChargeFixe;
    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(any())).thenReturn( unity_Montant_universelle.ChargeFixe,);
    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenAnswer((_) async => true);

    // Act
    await addMontantUniverselleUseCase.execute(
      icones: 1,
      nom: 'newNom',
      montant: 100.0,
      id: 'newId',
      unity: 'newUnity',
      listMontantUniverselle: listMontantUniverselle,
    );

    // Assert
    expect(listMontantUniverselle.length, 2);
    final addedMontant = listMontantUniverselle[1];
    expect(addedMontant.unity, unityDescription);
    expect(addedMontant.id, 'newId');
    expect(addedMontant.montant, 100.0);
    expect(addedMontant.nom, 'newNom');
    expect(addedMontant.descriptionUniverselle, isEmpty);
    expect(addedMontant.achat, isEmpty);
    expect(addedMontant.previsionsTotal, 0);
    expect(addedMontant.icones, 1);
    verify(() => mockSaveMontantUniverselleUseCase.execute(listMontantUniverselle, false)).called(1);
  });

  test('Should handle exception from saveMontantUniverselleUseCase', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
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

    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(any())).thenReturn( unity_Montant_universelle.ChargeFixe,);
    when(() => mockSaveMontantUniverselleUseCase.execute(any(), any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await addMontantUniverselleUseCase.execute(
        icones: 1,
        nom: 'newNom',
        montant: 100.0,
        id: 'newId',
        unity: 'newUnity',
        listMontantUniverselle: listMontantUniverselle,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
