import 'package:easyeconomy/controllers/list_montant_prevision_controller.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/montantPrevision/montant_prevision_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/change_icons_simulation_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/change_prix_simulation_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/change_titre_simulation_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/remove_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/reset_list_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/toggle_active_montant_prevision_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockMontantPrevisionGetDataSharedPreferences extends Mock implements MontantPrevisionGetDataSharedPreferences {}
class MockAddMontantPrevisionUseCase extends Mock implements AddMontantPrevisionUseCase {}
class MockChangeIconsSimulationUseCase extends Mock implements ChangeIconsSimulationUseCase {}
class MockChangePrixSimulationUseCase extends Mock implements ChangePrixSimulationUseCase {}
class MockChangeTitreSimulationUseCase extends Mock implements ChangeTitreSimulationUseCase {}
class MockLoadMontantPrevisionUseCase extends Mock implements LoadMontantPrevisionUseCase {}
class MockRemoveMontantPrevisionUseCase extends Mock implements RemoveMontantPrevisionUseCase {}
class MockResetListMontantPrevisionUseCase extends Mock implements ResetListMontantPrevisionUseCase {}
class MockSaveMontantprevisionUseCase extends Mock implements SaveMontantprevisionUseCase {}
class MockToggleActiveMontantPrevisionUseCase extends Mock implements ToggleActiveMontantPrevisionUseCase {}

void main() {
  late ListMontantPrevisionController controller;
  late MockMontantPrevisionGetDataSharedPreferences mockGetDataSharedPreferences;
  late MockAddMontantPrevisionUseCase mockAddMontantPrevisionUseCase;
  late MockChangeIconsSimulationUseCase mockChangeIconsSimulationUseCase;
  late MockChangePrixSimulationUseCase mockChangePrixSimulationUseCase;
  late MockChangeTitreSimulationUseCase mockChangeTitreSimulationUseCase;
  late MockLoadMontantPrevisionUseCase mockLoadMontantPrevisionUseCase;
  late MockRemoveMontantPrevisionUseCase mockRemoveMontantPrevisionUseCase;
  late MockResetListMontantPrevisionUseCase mockResetListMontantPrevisionUseCase;
  late MockSaveMontantprevisionUseCase mockSaveUseCase;
  late MockToggleActiveMontantPrevisionUseCase mockToggleActiveMontantPrevisionUseCase;

  setUp(() {
    mockGetDataSharedPreferences = MockMontantPrevisionGetDataSharedPreferences();
    mockAddMontantPrevisionUseCase = MockAddMontantPrevisionUseCase();
    mockChangeIconsSimulationUseCase = MockChangeIconsSimulationUseCase();
    mockChangePrixSimulationUseCase = MockChangePrixSimulationUseCase();
    mockChangeTitreSimulationUseCase = MockChangeTitreSimulationUseCase();
    mockLoadMontantPrevisionUseCase = MockLoadMontantPrevisionUseCase();
    mockRemoveMontantPrevisionUseCase = MockRemoveMontantPrevisionUseCase();
    mockResetListMontantPrevisionUseCase = MockResetListMontantPrevisionUseCase();
    mockSaveUseCase = MockSaveMontantprevisionUseCase();
    mockToggleActiveMontantPrevisionUseCase = MockToggleActiveMontantPrevisionUseCase();

    controller = ListMontantPrevisionController(
      mockGetDataSharedPreferences,
      mockLoadMontantPrevisionUseCase,
      mockSaveUseCase,
      mockRemoveMontantPrevisionUseCase,
      mockAddMontantPrevisionUseCase,
      mockResetListMontantPrevisionUseCase,
      mockChangePrixSimulationUseCase,
      mockChangeTitreSimulationUseCase,
      mockChangeIconsSimulationUseCase,
      mockToggleActiveMontantPrevisionUseCase,
    );
  });

  group('loadData', () {
    test('should load data from shared preferences', () async {
      // Arrange
      final dataList = ['{"unity":"ChargeFixe","id":"id1","montant":100.0,"nom":"nom1","descriptionUniverselle":[],"achat":[],"previsionsTotal":0,"icones":1}'];
      when(() => mockGetDataSharedPreferences.execute()).thenAnswer((_) async => dataList);

      final expectedList = [
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
      when(() => mockLoadMontantPrevisionUseCase.execute(any())).thenAnswer((_) async => expectedList);

      // Act
      final result = await controller.loadData();

      // Assert
      expect(result, expectedList);
      verify(() => mockGetDataSharedPreferences.execute()).called(1);
      verify(() => mockLoadMontantPrevisionUseCase.execute(any())).called(1);
    });

    test('should return empty list if no data is found', () async {
      // Arrange
      when(() => mockGetDataSharedPreferences.execute()).thenAnswer((_) async => null);

      // Act
      final result = await controller.loadData();

      // Assert
      expect(result, []);
      verify(() => mockGetDataSharedPreferences.execute()).called(1);
      verifyNever(() => mockLoadMontantPrevisionUseCase.execute(any()));
    });
  });

  group('addMontantPrevision', () {
    test('should add montant prevision using use case', () async {
      // Arrange
      final listMontantPrevision = <MontantUniverselle>[];

      when(() => mockAddMontantPrevisionUseCase.execute(
        icones: any(named: 'icones'),
        nom: any(named: 'nom'),
        montant: any(named: 'montant'),
        id: any(named: 'id'),
        unity: any(named: 'unity'),
        listMontantPrevision: any(named: 'listMontantPrevision'),
      )).thenAnswer((_) async {});

      // Act
      await controller.addMontantPrevision(
        icones: 1,
        nom: 'nom1',
        montant: 100.0,
        id: 'id1',
        unity: 'ChargeFixe',
        listMontantPrevision: listMontantPrevision,
      );

      // Assert
      verify(() => mockAddMontantPrevisionUseCase.execute(
        icones: 1,
        nom: 'nom1',
        montant: 100.0,
        id: 'id1',
        unity: 'ChargeFixe',
        listMontantPrevision: listMontantPrevision,
      )).called(1);
    });
  });

  group('removeMontantPrevision', () {
    test('should remove montant prevision using use case', () async {
      // Arrange
      final listMontantPrevision = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockRemoveMontantPrevisionUseCase.execute(
        index: any(named: 'index'),
        listMontantPrevision: any(named: 'listMontantPrevision'),
      )).thenAnswer((_) async {});

      // Act
      await controller.removeMontantPrevision(
        index: 0,
        listMontantPrevision: listMontantPrevision,
      );

      // Assert
      verify(() => mockRemoveMontantPrevisionUseCase.execute(
        index: 0,
        listMontantPrevision: listMontantPrevision,
      )).called(1);
    });
  });

  group('resetListMontantPrevision', () {
    test('should reset list montant prevision using use case', () async {
      // Arrange
      final listMontantPrevision = <MontantUniverselle>[];
      final listMontantUniverselle = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockResetListMontantPrevisionUseCase.execute(
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
        listMontantPrevision: any(named: 'listMontantPrevision'),
      )).thenAnswer((_) async {});

      // Act
      await controller.resetListMontantPrevision(
        listMontantUniverselle: listMontantUniverselle,
        listMontantPrevision: listMontantPrevision,
      );

      // Assert
      verify(() => mockResetListMontantPrevisionUseCase.execute(
        listMontantUniverselle: listMontantUniverselle,
        listMontantPrevision: listMontantPrevision,
      )).called(1);
    });
  });

  group('changePrixSimulation', () {
    test('should change prix simulation using use case', () async {
      // Arrange
      final listMontantPrevision = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockChangePrixSimulationUseCase.execute(
        montant: any(named: 'montant'),
        indexGestion: any(named: 'indexGestion'),
        listMontantPrevision: any(named: 'listMontantPrevision'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changePrixSimulation(
        montant: '200.0',
        indexGestion: 0,
        listMontantPrevision: listMontantPrevision,
      );

      // Assert
      verify(() => mockChangePrixSimulationUseCase.execute(
        montant: '200.0',
        indexGestion: 0,
        listMontantPrevision: listMontantPrevision,
      )).called(1);
    });
  });

  group('changeTitreSimulation', () {
    test('should change titre simulation using use case', () async {
      // Arrange
      final listMontantPrevision = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockChangeTitreSimulationUseCase.execute(
        nom: any(named: 'nom'),
        indexGestion: any(named: 'indexGestion'),
        listMontantPrevision: any(named: 'listMontantPrevision'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changeTitreSimulation(
        nom: 'nouveau nom',
        indexGestion: 0,
        listMontantPrevision: listMontantPrevision,
      );

      // Assert
      verify(() => mockChangeTitreSimulationUseCase.execute(
        nom: 'nouveau nom',
        indexGestion: 0,
        listMontantPrevision: listMontantPrevision,
      )).called(1);
    });
  });

  group('changeIconsSimulation', () {
    test('should change icons simulation using use case', () async {
      // Arrange
      final listMontantPrevision = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockChangeIconsSimulationUseCase.execute(
        icons: any(named: 'icons'),
        indexGestion: any(named: 'indexGestion'),
        listMontantPrevision: any(named: 'listMontantPrevision'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changeIconsSimulation(
        icons: 2,
        indexGestion: 0,
        listMontantPrevision: listMontantPrevision,
      );

      // Assert
      verify(() => mockChangeIconsSimulationUseCase.execute(
        icons: 2,
        indexGestion: 0,
        listMontantPrevision: listMontantPrevision,
      )).called(1);
    });
  });

  group('toggleActiveMontantPrevision', () {
    test('should toggle active montant prevision using use case', () async {
      // Arrange
      final listMontantPrevision = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockToggleActiveMontantPrevisionUseCase.execute(
        index: any(named: 'index'),
        listMontantPrevision: any(named: 'listMontantPrevision'),
      )).thenAnswer((_) async {});

      // Act
      await controller.toggleActiveMontantPrevision(
        index: 0,
        listMontantPrevision: listMontantPrevision,
      );

      // Assert
      verify(() => mockToggleActiveMontantPrevisionUseCase.execute(
        index: 0,
        listMontantPrevision: listMontantPrevision,
      )).called(1);
    });
  });

  group('saveMontantPrevision', () {
    test('should save MontantPrevision list using use case', () async {
      // Arrange
      final listMontantPrevision = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockSaveUseCase.execute(
        any<List<MontantUniverselle>>(),
        remove: any(named: 'remove'),
      )).thenAnswer((_) async => true);

      // Act
      final result = await controller.saveMontantPrevision(listMontantPrevision, remove: true);

      // Assert
      expect(result, true);
      verify(() => mockSaveUseCase.execute(
        listMontantPrevision,
        remove: true,
      )).called(1);
    });
  });
}
