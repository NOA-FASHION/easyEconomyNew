import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_achat_total_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}
class MockGestionMensuel extends Mock implements GestionMensuel {}
class MockMontantUniverselle extends Mock implements MontantUniverselle {}
class MockDescriptionUniverselle extends Mock implements DesciprtionUniverselle {}

void main() {
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late AddAchatTotalUseCase addAchatTotalUseCase;

  setUp(() {
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    addAchatTotalUseCase = AddAchatTotalUseCase(mockSaveGestionMensuelUseCase);
  });

  test('Should add achat to the specified gestion and save the list', () async {
    // Arrange
    final description = MockDescriptionUniverselle();
    when(() => description.previsions).thenReturn(200);

    final montantUniverselle = MockMontantUniverselle();
    when(() => montantUniverselle.descriptionUniverselle).thenReturn([description]);
    when(() => montantUniverselle.achat).thenReturn(<double>[]);

    final gestionMensuel = MockGestionMensuel();
    when(() => gestionMensuel.montantUniverselle).thenReturn([montantUniverselle]);

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];
    final int indexGestion = 0; 
    final int indexGestionLive = 0; 
    final int indexGestionDescription = 0;

    when(() => mockSaveGestionMensuelUseCase.execute(any())).thenAnswer((_) async {
      return false;
    });

    // Act
    await addAchatTotalUseCase.execute(
      indexGestion: indexGestion,
      indexGestionLive: indexGestionLive,
      indexGestionDescription: indexGestionDescription,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    verify(() => mockSaveGestionMensuelUseCase.execute(any())).called(1);
    verify(() => gestionMensuel.montantUniverselle[indexGestionLive].achat.add(200)).called(2);
  });
}
