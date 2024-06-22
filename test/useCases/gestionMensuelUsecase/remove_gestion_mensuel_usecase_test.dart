import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}

void main() {
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late RemoveGestionMensuelUseCase removeGestionMensuelUseCase;

  setUpAll(() {
    registerFallbackValue(GestionMensuel(
      idGestion: 'idGestion',
      nom: 'nom',
      mois: 'mois',
      tendance: 'tendance',
      montantUniverselle: [],
      montantUniverselleLive: [],
    ));
  });

  setUp(() {
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    removeGestionMensuelUseCase = RemoveGestionMensuelUseCase(mockSaveGestionMensuelUseCase);
  });

  test('Should remove gestion and save the list', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
      GestionMensuel(
        idGestion: '2',
        nom: 'Gestion2',
        mois: 'Feb',
        tendance: 'increasing',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: any(named: 'remove'),
    )).thenAnswer((_) async => Future.value(false));

    // Act
    await removeGestionMensuelUseCase.execute(
      index: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel.length, 1);
    expect(listGestionMensuel[0].idGestion, '2');
    verify(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: true,
    )).called(1);
  });

  test('Should handle index out of range and do nothing', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
    ];

    // Act
    await removeGestionMensuelUseCase.execute(
      index: 5,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel.length, 1);
    verifyNever(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: true,
    ));
  });

  test('Should handle exception from saveGestionMensuelUseCase', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
      GestionMensuel(
        idGestion: '2',
        nom: 'Gestion2',
        mois: 'Feb',
        tendance: 'increasing',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: any(named: 'remove'),
    )).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await removeGestionMensuelUseCase.execute(
        index: 0,
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
