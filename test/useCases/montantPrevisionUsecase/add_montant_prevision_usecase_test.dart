import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';

class MockChoixDesciptionDetailsFinanceEnumUseCase extends Mock implements ChoixDesciptionDetailsFinanceEnumUseCase {}

class MockSaveMontantprevisionUseCase extends Mock implements SaveMontantprevisionUseCase {}

void main() {
  late MockChoixDesciptionDetailsFinanceEnumUseCase mockChoixDesciptionDetailsFinanceEnumUseCase;
  late MockSaveMontantprevisionUseCase mockSaveMontantprevisionUseCase;
  late AddMontantPrevisionUseCase addMontantPrevisionUseCase;

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
    mockChoixDesciptionDetailsFinanceEnumUseCase = MockChoixDesciptionDetailsFinanceEnumUseCase();
    mockSaveMontantprevisionUseCase = MockSaveMontantprevisionUseCase();
    addMontantPrevisionUseCase = AddMontantPrevisionUseCase(
      mockSaveMontantprevisionUseCase, 
      mockChoixDesciptionDetailsFinanceEnumUseCase,
    );
  });

  test('Should add MontantUniverselle to list and save the list', () async {
    // Arrange
    final List<MontantUniverselle> listMontantPrevision = [];

    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(any()))
      .thenReturn( unity_Montant_universelle.ChargeFixe,);

    when(() => mockSaveMontantprevisionUseCase.execute(any()))
      .thenAnswer((_) async => true);

    // Act
    await addMontantPrevisionUseCase.execute(
      icones: 1,
      nom: 'Test Name',
      montant: 100.0,
      id: 'testId',
      unity: 'Test Unity',
      listMontantPrevision: listMontantPrevision,
    );

    // Assert
    expect(listMontantPrevision.length, 1);
    expect(listMontantPrevision[0].unity, unity_Montant_universelle.ChargeFixe);
    expect(listMontantPrevision[0].id, 'testId');
    expect(listMontantPrevision[0].montant, 100.0);
    expect(listMontantPrevision[0].nom, 'Test Name');
    expect(listMontantPrevision[0].icones, 1);

    verify(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute('Test Unity')).called(1);
    verify(() => mockSaveMontantprevisionUseCase.execute(listMontantPrevision)).called(1);
  });

  test('Should handle exception from saveMontantprevisionUseCase', () async {
    // Arrange
    final List<MontantUniverselle> listMontantPrevision = [];

    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(any()))
      .thenReturn(unity_Montant_universelle.ChargeFixe);

    when(() => mockSaveMontantprevisionUseCase.execute(any()))
      .thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await addMontantPrevisionUseCase.execute(
        icones: 1,
        nom: 'Test Name',
        montant: 100.0,
        id: 'testId',
        unity: 'Test Unity',
        listMontantPrevision: listMontantPrevision,
      ),
      throwsA(isA<Exception>()),
    );

    verify(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute('Test Unity')).called(1);
    verify(() => mockSaveMontantprevisionUseCase.execute(any())).called(1);
  });
}
