
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/gestionMensuelServices/save_gestion_mensuel_sharedpreferencies.dart';

class MockSaveGestionMensuelSharedPreferencesService extends Mock implements SaveGestionMensuelSharedPreferencesService {}

void main() {
  late MockSaveGestionMensuelSharedPreferencesService mockSaveService;
  late SaveGestionMensuelUseCase saveGestionMensuelUseCase;

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
    mockSaveService = MockSaveGestionMensuelSharedPreferencesService();
    saveGestionMensuelUseCase = SaveGestionMensuelUseCase(mockSaveService);
  });

  test('Should save data and return true when list is not empty', () async {
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

    when(() => mockSaveService.saveData(any<List<String>>())).thenAnswer((_) async => true);

    // Act
    final result = await saveGestionMensuelUseCase.execute(listGestionMensuel);

    // Assert
    expect(result, true);
    verify(() => mockSaveService.saveData(any<List<String>>())).called(1);
  });

  test('Should handle removal and save empty list when list length is less than 1 and remove is true', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [];

    when(() => mockSaveService.saveData(any<List<String>>())).thenAnswer((_) async => true);

    // Act
    final result = await saveGestionMensuelUseCase.execute(listGestionMensuel, remove: true);

    // Assert
    expect(result, true);
    verify(() => mockSaveService.saveData([])).called(1);
  });

  test('Should return false when list is empty and remove is false', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [];

    // Act
    final result = await saveGestionMensuelUseCase.execute(listGestionMensuel);

    // Assert
    expect(result, false);
    verifyNever(() => mockSaveService.saveData(any<List<String>>()));
  });

  test('Should handle exception from saveService', () async {
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

    when(() => mockSaveService.saveData(any<List<String>>())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await saveGestionMensuelUseCase.execute(listGestionMensuel),
      throwsA(isA<Exception>()),
    );
  });
}
