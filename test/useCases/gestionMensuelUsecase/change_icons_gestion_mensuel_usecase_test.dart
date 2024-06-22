import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/change_icons_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';

class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}
class MockGestionMensuel extends Mock implements GestionMensuel {}
class MockMontantUniverselle extends Mock implements MontantUniverselle {}

void main() {
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late ChangeIconsGestionMensuelUseCase changeIconsGestionMensuelUseCase;

  setUp(() {
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    changeIconsGestionMensuelUseCase = ChangeIconsGestionMensuelUseCase(mockSaveGestionMensuelUseCase);
  });

  test('Should change the icons of the specified montantUniverselle and save the list', () async {
    // Arrange
    final montantUniverselle = MockMontantUniverselle();
    when(() => montantUniverselle.icones).thenReturn(1);

    final gestionMensuel = MockGestionMensuel();
    when(() => gestionMensuel.montantUniverselle).thenReturn([montantUniverselle]);

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];
    final int newIcon = 5;
    final int indexGestionMensuel = 0;
    final int indexGestion = 0;

    when(() => mockSaveGestionMensuelUseCase.execute(any())).thenAnswer((_) async {
      return false;
    });

    // Act
    await changeIconsGestionMensuelUseCase.execute(
      icons: newIcon,
      indexGestionMensuel: indexGestionMensuel,
      indexGestion: indexGestion,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    verify(() => gestionMensuel.montantUniverselle[indexGestion].icones = newIcon).called(1);
    verify(() => mockSaveGestionMensuelUseCase.execute(listGestionMensuel)).called(1);
  });

  test('Should handle exception and not save if there is an error', () async {
    // Arrange
    final montantUniverselle = MockMontantUniverselle();
    when(() => montantUniverselle.icones).thenReturn(1);

    final gestionMensuel = MockGestionMensuel();
    when(() => gestionMensuel.montantUniverselle).thenReturn([montantUniverselle]);

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];
    final int newIcon = 5;
    final int indexGestionMensuel = 0;
    final int indexGestion = 0;

    when(() => mockSaveGestionMensuelUseCase.execute(any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await changeIconsGestionMensuelUseCase.execute(
        icons: newIcon,
        indexGestionMensuel: indexGestionMensuel,
        indexGestion: indexGestion,
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );

    verify(() => gestionMensuel.montantUniverselle[indexGestion].icones = newIcon).called(1);
    verify(() => mockSaveGestionMensuelUseCase.execute(listGestionMensuel)).called(1);
  });
}
