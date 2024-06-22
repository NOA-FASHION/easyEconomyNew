import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:intl/intl.dart';

class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}
class MockChoixDesciptionDetailsFinanceEnumUseCase extends Mock implements ChoixDesciptionDetailsFinanceEnumUseCase {}
class MockGestionMensuel extends Mock implements GestionMensuel {}
class MockMontantUniverselle extends Mock implements MontantUniverselle {}

void main() {
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late MockChoixDesciptionDetailsFinanceEnumUseCase mockChoixDesciptionDetailsFinanceEnumUseCase;
  late AddMontantGestionUseCase addMontantGestionUseCase;

  setUp(() {
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    mockChoixDesciptionDetailsFinanceEnumUseCase = MockChoixDesciptionDetailsFinanceEnumUseCase();
    addMontantGestionUseCase = AddMontantGestionUseCase(
      mockSaveGestionMensuelUseCase,
      mockChoixDesciptionDetailsFinanceEnumUseCase,
    );
  });

  test('Should add MontantUniverselle to montantUniverselle and save the list if month matches', () async {
    // Arrange
     final unity = 'ChargeFixe';
    final processedUnity = unity_Montant_universelle.ChargeFixe;
    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(unity)).thenReturn(processedUnity);

    final gestionMensuel = MockGestionMensuel();
    final montantUniverselle = <MontantUniverselle>[];
    when(() => gestionMensuel.montantUniverselle).thenReturn(montantUniverselle);
    when(() => gestionMensuel.mois).thenReturn(DateFormat('MMM').format(DateTime.now()));

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];

    when(() => mockSaveGestionMensuelUseCase.execute(any(), remove: any(named: 'remove'))).thenAnswer((_) async {
      return false;
    });

    // Act
    await addMontantGestionUseCase.execute(
      icones: 1,
      nom: 'Test',
      montant: 100.0,
      id: '123',
      unity: unity,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    verify(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(unity)).called(1);
    verify(() => gestionMensuel.montantUniverselle.add(any())).called(1);
    verify(() => mockSaveGestionMensuelUseCase.execute(any(), remove: false)).called(1);
    expect(montantUniverselle.length, 1);
    expect(montantUniverselle[0].unity, processedUnity);
  });

  test('Should not add MontantUniverselle if no month matches', () async {
    // Arrange
     final unity = 'ChargeFixe';
    final processedUnity = unity_Montant_universelle.ChargeFixe;
    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(unity)).thenReturn(processedUnity);

    final gestionMensuel = MockGestionMensuel();
    final montantUniverselle = <MontantUniverselle>[];
    when(() => gestionMensuel.montantUniverselle).thenReturn(montantUniverselle);
    when(() => gestionMensuel.mois).thenReturn('Jan');

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];

    // Act
    await addMontantGestionUseCase.execute(
      icones: 1,
      nom: 'Test',
      montant: 100.0,
      id: '123',
      unity: unity,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    verifyNever(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(any()));
    verifyNever(() => gestionMensuel.montantUniverselle.add(any()));
    verifyNever(() => mockSaveGestionMensuelUseCase.execute(any(), remove: any(named: 'remove')));
    expect(montantUniverselle, isEmpty);
  });

  test('Should handle exception and not add MontantUniverselle', () async {
    // Arrange
     final unity = 'ChargeFixe';
    final processedUnity = unity_Montant_universelle.ChargeFixe;
    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(unity)).thenReturn(processedUnity);

    final gestionMensuel = MockGestionMensuel();
    final montantUniverselle = <MontantUniverselle>[];
    when(() => gestionMensuel.montantUniverselle).thenReturn(montantUniverselle);
    when(() => gestionMensuel.mois).thenReturn(DateFormat('MMM').format(DateTime.now()));

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];

    when(() => mockSaveGestionMensuelUseCase.execute(any(), remove: any(named: 'remove')))
        .thenThrow(Exception('Save failed'));

    // Act
    try {
      await addMontantGestionUseCase.execute(
        icones: 1,
        nom: 'Test',
        montant: 100.0,
        id: '123',
        unity: unity,
        listGestionMensuel: listGestionMensuel,
      );
    } catch (e) {
      // Assert
      expect(e, isA<Exception>());
      verify(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(unity)).called(1);
      verifyNever(() => gestionMensuel.montantUniverselle.add(any()));
      verify(() => mockSaveGestionMensuelUseCase.execute(any(), remove: false)).called(1);
      expect(montantUniverselle, isEmpty);
    }
  });
}
