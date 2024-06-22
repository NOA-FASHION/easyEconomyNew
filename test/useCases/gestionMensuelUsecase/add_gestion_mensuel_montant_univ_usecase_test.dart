import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}
class MockChoixDesciptionDetailsFinanceEnumUseCase extends Mock implements ChoixDesciptionDetailsFinanceEnumUseCase {}
class MockGestionMensuel extends Mock implements GestionMensuel {}
class MockMontantUniverselle extends Mock implements MontantUniverselle {}

void main() {
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late MockChoixDesciptionDetailsFinanceEnumUseCase mockChoixDesciptionDetailsFinanceEnumUseCase;
  late AddGestionMensuelMontantUnivUseCase addGestionMensuelMontantUnivUseCase;

  setUp(() {
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    mockChoixDesciptionDetailsFinanceEnumUseCase = MockChoixDesciptionDetailsFinanceEnumUseCase();
    addGestionMensuelMontantUnivUseCase = AddGestionMensuelMontantUnivUseCase(
      mockSaveGestionMensuelUseCase,
      mockChoixDesciptionDetailsFinanceEnumUseCase,
    );
  });

  test('Should add MontantUniverselle to montantUniverselle and save the list', () async {
    // Arrange
    final unity = 'ChargeFixe';
    final processedUnity = unity_Montant_universelle.ChargeFixe;
    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(unity)).thenReturn(processedUnity);

    final gestionMensuel = MockGestionMensuel();
    final montantUniverselle = <MontantUniverselle>[];
    when(() => gestionMensuel.montantUniverselle).thenReturn(montantUniverselle);

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];
    final int index = 0;

    when(() => mockSaveGestionMensuelUseCase.execute(any(), remove: any(named: 'remove'))).thenAnswer((_) async {
      return false;
    });

    // Act
    await addGestionMensuelMontantUnivUseCase.execute(
      icones: 1,
      nom: 'Test',
      montant: 100.0,
      id: '123',
      unity: unity,
      index: index,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    verify(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(unity)).called(1);
    verify(() => gestionMensuel.montantUniverselle.add(any())).called(1);
    verify(() => mockSaveGestionMensuelUseCase.execute(any(), remove: false)).called(1);
    expect(montantUniverselle.length, 1);
    expect(montantUniverselle[0].unity, processedUnity);
  });

  test('Should handle exception and not add MontantUniverselle', () async {
    // Arrange
    final unity = 'ChargeFixe';
    final processedUnity = unity_Montant_universelle.ChargeFixe;
    when(() => mockChoixDesciptionDetailsFinanceEnumUseCase.execute(unity)).thenReturn(processedUnity);

    final gestionMensuel = MockGestionMensuel();
    final montantUniverselle = <MontantUniverselle>[];
    when(() => gestionMensuel.montantUniverselle).thenReturn(montantUniverselle);

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];
    final int index = 0;

    when(() => mockSaveGestionMensuelUseCase.execute(any(), remove: any(named: 'remove')))
        .thenThrow(Exception('Save failed'));

    // Act
    try {
      await addGestionMensuelMontantUnivUseCase.execute(
        icones: 1,
        nom: 'Test',
        montant: 100.0,
        id: '123',
        unity: unity,
        index: index,
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
