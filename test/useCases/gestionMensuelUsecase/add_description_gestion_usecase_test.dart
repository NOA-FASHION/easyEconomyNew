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

    final achatList = <double>[];
    final montantUniverselle = MockMontantUniverselle();
    when(() => montantUniverselle.descriptionUniverselle).thenReturn([description]);
    when(() => montantUniverselle.achat).thenReturn(achatList);

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
    expect(achatList, contains(200));
  });

  test('Should add achat to the second gestion and save the list', () async {
    // Arrange
    final description1 = MockDescriptionUniverselle();
    final description2 = MockDescriptionUniverselle();
    when(() => description1.previsions).thenReturn(100);
    when(() => description2.previsions).thenReturn(200);

    final achatList1 = <double>[];
    final achatList2 = <double>[];
    final montantUniverselle1 = MockMontantUniverselle();
    final montantUniverselle2 = MockMontantUniverselle();
    when(() => montantUniverselle1.descriptionUniverselle).thenReturn([description1]);
    when(() => montantUniverselle1.achat).thenReturn(achatList1);
    when(() => montantUniverselle2.descriptionUniverselle).thenReturn([description2]);
    when(() => montantUniverselle2.achat).thenReturn(achatList2);

    final gestionMensuel1 = MockGestionMensuel();
    final gestionMensuel2 = MockGestionMensuel();
    when(() => gestionMensuel1.montantUniverselle).thenReturn([montantUniverselle1]);
    when(() => gestionMensuel2.montantUniverselle).thenReturn([montantUniverselle2]);

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel1, gestionMensuel2];
    final int indexGestion = 1;
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
    expect(achatList2, contains(200));
  });

  // test('Should handle exception and not add achat', () async {
  //   // Arrange
  //   final description = MockDescriptionUniverselle();
  //   when(() => description.previsions).thenReturn(200);

  //   final achatList = <double>[];
  //   final montantUniverselle = MockMontantUniverselle();
  //   when(() => montantUniverselle.descriptionUniverselle).thenReturn([description]);
  //   when(() => montantUniverselle.achat).thenReturn(achatList);

  //   final gestionMensuel = MockGestionMensuel();
  //   when(() => gestionMensuel.montantUniverselle).thenReturn([montantUniverselle]);

  //   final List<GestionMensuel> listGestionMensuel = [gestionMensuel];
  //   final int indexGestion = 0;
  //   final int indexGestionLive = 0;
  //   final int indexGestionDescription = 0;

  //   when(() => mockSaveGestionMensuelUseCase.execute(any())).thenThrow(Exception('Save failed'));

  //   // Act
  //   try {
  //     await addAchatTotalUseCase.execute(
  //       indexGestion: indexGestion,
  //       indexGestionLive: indexGestionLive,
  //       indexGestionDescription: indexGestionDescription,
  //       listGestionMensuel: listGestionMensuel,
  //     );
  //   } catch (e) {
  //     // Assert
  //     expect(e, isA<Exception>());
  //     verify(() => mockSaveGestionMensuelUseCase.execute(any())).called(1);
  //     expect(achatList, isEmpty);
  //   }
  // });

  test('Should throw an error when listGestionMensuel is empty', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [];
    final int indexGestion = 0;
    final int indexGestionLive = 0;
    final int indexGestionDescription = 0;

    when(() => mockSaveGestionMensuelUseCase.execute(any())).thenAnswer((_) async {
      return false;
    });

    // Act & Assert
    expect(
      () async => await addAchatTotalUseCase.execute(
        indexGestion: indexGestion,
        indexGestionLive: indexGestionLive,
        indexGestionDescription: indexGestionDescription,
        listGestionMensuel: listGestionMensuel,
      ),
      throwsRangeError,
    );
    verifyNever(() => mockSaveGestionMensuelUseCase.execute(any()));
  });
}
