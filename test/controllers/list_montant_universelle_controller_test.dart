import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:easyeconomy/controllers/list_montant_universelle_controller.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/services/montantUniverselleServices/montant_universelle_get_data_sharedpreferencies.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/remove_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/change_icons_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/change_titre_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/change_prix_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/toggle_active_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/add_description_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/remove_description_montant_universelle_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/echeance_no_passe_montan_unive_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/echeance_passe_montan_unive_usecase.dart';

class MockMontantUniverselleGetDataSharedpreferencies extends Mock implements MontantUniverselleGetDataSharedpreferencies {}
class MockLoadMontantUniverselleUseCase extends Mock implements LoadMontantUniverselleUseCase {}
class MockChangeIconsUseCase extends Mock implements ChangeIconsUseCase {}
class MockSaveMontantUniverselleUseCase extends Mock implements SaveMontantUniverselleUseCase {}
class MockAddDescriptionMontantUniverselleUseCase extends Mock implements AddDescriptionMontantUniverselleUseCase {}
class MockEcheanceNoPasseMontanUniveUseCase extends Mock implements EcheanceNoPasseMontanUniveUseCase {}
class MockToggleActiveMontantUniverselleUseCase extends Mock implements ToggleActiveMontantUniverselleUseCase {}
class MockChangeTitreUseCase extends Mock implements ChangeTitreUseCase {}
class MockAddMontantUniverselleUseCase extends Mock implements AddMontantUniverselleUseCase {}
class MockChangePrixUseCase extends Mock implements ChangePrixUseCase {}
class MockRemoveMontantUniverselleUseCase extends Mock implements RemoveMontantUniverselleUseCase {}
class MockRemoveDescriptionMontantUniverselleUseCase extends Mock implements RemoveDescriptionMontantUniverselleUseCase {}
class MockEcheancePasseMontanUniveUseCase extends Mock implements EcheancePasseMontanUniveUseCase {}

void main() {
  late ListMontantUniverselleController controller;
  late MockMontantUniverselleGetDataSharedpreferencies mockGetDataService;
  late MockLoadMontantUniverselleUseCase mockLoadUseCase;
  late MockChangeIconsUseCase mockChangeIconsUseCase;
  late MockSaveMontantUniverselleUseCase mockSaveUseCase;
  late MockAddDescriptionMontantUniverselleUseCase mockAddDescriptionUseCase;
  late MockEcheanceNoPasseMontanUniveUseCase mockEcheanceNoPasseUseCase;
  late MockToggleActiveMontantUniverselleUseCase mockToggleActiveUseCase;
  late MockChangeTitreUseCase mockChangeTitreUseCase;
  late MockAddMontantUniverselleUseCase mockAddMontantUseCase;
  late MockChangePrixUseCase mockChangePrixUseCase;
  late MockRemoveMontantUniverselleUseCase mockRemoveMontantUseCase;
  late MockRemoveDescriptionMontantUniverselleUseCase mockRemoveDescriptionUseCase;
  late MockEcheancePasseMontanUniveUseCase mockEcheancePasseUseCase;

  setUp(() {
    mockGetDataService = MockMontantUniverselleGetDataSharedpreferencies();
    mockLoadUseCase = MockLoadMontantUniverselleUseCase();
    mockChangeIconsUseCase = MockChangeIconsUseCase();
    mockSaveUseCase = MockSaveMontantUniverselleUseCase();
    mockAddDescriptionUseCase = MockAddDescriptionMontantUniverselleUseCase();
    mockEcheanceNoPasseUseCase = MockEcheanceNoPasseMontanUniveUseCase();
    mockToggleActiveUseCase = MockToggleActiveMontantUniverselleUseCase();
    mockChangeTitreUseCase = MockChangeTitreUseCase();
    mockAddMontantUseCase = MockAddMontantUniverselleUseCase();
    mockChangePrixUseCase = MockChangePrixUseCase();
    mockRemoveMontantUseCase = MockRemoveMontantUniverselleUseCase();
    mockRemoveDescriptionUseCase = MockRemoveDescriptionMontantUniverselleUseCase();
    mockEcheancePasseUseCase = MockEcheancePasseMontanUniveUseCase();

    controller = ListMontantUniverselleController(
      mockGetDataService,
      mockLoadUseCase,
      mockSaveUseCase,
      mockAddMontantUseCase,
      mockRemoveMontantUseCase,
      mockAddDescriptionUseCase,
      mockRemoveDescriptionUseCase,
      mockEcheancePasseUseCase,
      mockEcheanceNoPasseUseCase,
      mockChangePrixUseCase,
      mockChangeTitreUseCase,
      mockChangeIconsUseCase,
      mockToggleActiveUseCase,
    );
  });

  group('loadData', () {
    test('should load data from service and use case', () async {
      // Arrange
      final jsonData = [
        '{"unity": "unity1", "id": "id1", "montant": 100.0, "nom": "nom1", "descriptionUniverselle": [], "achat": [], "previsionsTotal": 0, "icones": 1}',
        '{"unity": "unity2", "id": "id2", "montant": 200.0, "nom": "nom2", "descriptionUniverselle": [], "achat": [], "previsionsTotal": 0, "icones": 2}'
      ];
      final listMontantUniverselle = [
        MontantUniverselle(unity:  unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
        MontantUniverselle(unity:  unity_Montant_universelle.ChargeFixe, id: 'id2', montant: 200.0, nom: 'nom2', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 2),
      ];

      when(() => mockGetDataService.execute()).thenAnswer((_) async => jsonData);
      when(() => mockLoadUseCase.execute(any())).thenAnswer((_) async => listMontantUniverselle);

      // Act
      final result = await controller.loadData();

      // Assert
      expect(result, listMontantUniverselle);
      verify(() => mockGetDataService.execute()).called(1);
      verify(() => mockLoadUseCase.execute(any())).called(1);
    });

    test('should return empty list if no data is loaded', () async {
      // Arrange
      when(() => mockGetDataService.execute()).thenAnswer((_) async => null);

      // Act
      final result = await controller.loadData();

      // Assert
      expect(result, []);
      verify(() => mockGetDataService.execute()).called(1);
      verifyNever(() => mockLoadUseCase.execute(any()));
    });
  });

  group('addMontanUniverselle', () {
    test('should add MontantUniverselle using use case', () async {
      // Arrange
      final listMontantUniverselle = <MontantUniverselle>[];

      when(() => mockAddMontantUseCase.execute(
        icones: any(named: 'icones'),
        nom: any(named: 'nom'),
        montant: any(named: 'montant'),
        id: any(named: 'id'),
        unity: any(named: 'unity'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
      )).thenAnswer((_) async {});

      // Act
      await controller.addMontanUniverselle(
        icones: 1,
        nom: 'nom',
        montant: 100.0,
        id: 'id',
        unity: 'unity',
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockAddMontantUseCase.execute(
        icones: 1,
        nom: 'nom',
        montant: 100.0,
        id: 'id',
        unity: 'unity',
        listMontantUniverselle: listMontantUniverselle,
      )).called(1);
    });
  });

  group('removeMontantUniverselle', () {
    test('should remove MontantUniverselle using use case', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity:  unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockRemoveMontantUseCase.execute(
        index: any(named: 'index'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
      )).thenAnswer((_) async {});

      // Act
      await controller.removeMontantUniverselle(
        index: 0,
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockRemoveMontantUseCase.execute(
        index: 0,
        listMontantUniverselle: listMontantUniverselle,
      )).called(1);
    });
  });

  group('addDescriptionMontantUniverselle', () {
    test('should add description to MontantUniverselle using use case', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity:  unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockAddDescriptionUseCase.execute(
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
        achat: any(named: 'achat'),
        previsions: any(named: 'previsions'),
        echeance: any(named: 'echeance'),
        nombreEcheance: any(named: 'nombreEcheance'),
        id: any(named: 'id'),
        adresseImage: any(named: 'adresseImage'),
        name: any(named: 'name'),
        commentaire: any(named: 'commentaire'),
        indexChargeFixe: any(named: 'indexChargeFixe'),
        description: any(named: 'description'),
      )).thenAnswer((_) async {});

      // Act
      await controller.addDescriptionMontantUniverselle(
        achat: [10.0],
        previsions: 20.0,
        echeance: 2.0,
        nombreEcheance: 3.0,
        id: 'desc1',
        adresseImage: 'img.png',
        name: 'descName',
        commentaire: 'descComment',
        indexChargeFixe: 0,
        description: 'tache',
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockAddDescriptionUseCase.execute(
        listMontantUniverselle: listMontantUniverselle,
        achat: [10.0],
        previsions: 20.0,
        echeance: 2.0,
        nombreEcheance: 3.0,
        id: 'desc1',
        adresseImage: 'img.png',
        name: 'descName',
        commentaire: 'descComment',
        indexChargeFixe: 0,
        description: 'tache',
      )).called(1);
    });
  });

  group('removeDescriptionMontantUniverselle', () {
    test('should remove description from MontantUniverselle using use case', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [
          DesciprtionUniverselle(previsions: 10.0, echeance: 2, nombreEcheance: 3, id: '1', name: 'test', adresseImage: '', description: unity_description.tache, commentaire: '')
        ], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockRemoveDescriptionUseCase.execute(
        index: any(named: 'index'),
        indexChargeFixe: any(named: 'indexChargeFixe'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
      )).thenAnswer((_) async {});

      // Act
      await controller.removeDescriptionMontantUniverselle(
        index: 0,
        indexChargeFixe: 0,
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockRemoveDescriptionUseCase.execute(
        index: 0,
        indexChargeFixe: 0,
        listMontantUniverselle: listMontantUniverselle,
      )).called(1);
    });
  });

  group('echeancePasseMontanUnive', () {
    test('should call echeancePasseMontanUniveUseCase', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe,id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];
      final listGestionMensuel = [
        GestionMensuel(idGestion: 'id1', nom: 'Gestion1', mois: 'Jan', tendance: 'stable', montantUniverselle: listMontantUniverselle, montantUniverselleLive: []),
      ];

      when(() => mockEcheancePasseUseCase.execute(
        idGestionMensMontantUnv: any(named: 'idGestionMensMontantUnv'),
        indexGestion: any(named: 'indexGestion'),
        indexGestionLive: any(named: 'indexGestionLive'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.echeancePasseMontanUnive(
        idGestionMensMontantUnv: 'id1',
        indexGestion: 0,
        indexGestionLive: 0,
        listGestionMensuel: listGestionMensuel,
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockEcheancePasseUseCase.execute(
        idGestionMensMontantUnv: 'id1',
        indexGestion: 0,
        indexGestionLive: 0,
        listMontantUniverselle: listMontantUniverselle,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });
  });

  group('echeanceNoPasseMontanUnive', () {
    test('should call echeanceNoPasseMontanUniveUseCase', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity:  unity_Montant_universelle.ChargeFixe,id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];
      final listGestionMensuel = [
        GestionMensuel(idGestion: 'id1', nom: 'Gestion1', mois: 'Jan', tendance: 'stable', montantUniverselle: listMontantUniverselle, montantUniverselleLive: []),
      ];

      when(() => mockEcheanceNoPasseUseCase.execute(
        idGestionMensMontantUnv: any(named: 'idGestionMensMontantUnv'),
        indexGestion: any(named: 'indexGestion'),
        indexGestionLive: any(named: 'indexGestionLive'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.echeanceNoPasseMontanUnive(
        idGestionMensMontantUnv: 'id1',
        indexGestion: 0,
        indexGestionLive: 0,
        listGestionMensuel: listGestionMensuel,
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockEcheanceNoPasseUseCase.execute(
        idGestionMensMontantUnv: 'id1',
        indexGestion: 0,
        indexGestionLive: 0,
        listMontantUniverselle: listMontantUniverselle,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });
  });

  group('changePrix', () {
    test('should change prix of MontantUniverselle using use case', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity:  unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockChangePrixUseCase.execute(
        montant: any(named: 'montant'),
        indexGestion: any(named: 'indexGestion'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changePrix(
        montant: '200.0',
        indexGestion: 0,
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockChangePrixUseCase.execute(
        montant: '200.0',
        indexGestion: 0,
        listMontantUniverselle: listMontantUniverselle,
      )).called(1);
    });
  });

  group('changeTitre', () {
    test('should change titre of MontantUniverselle using use case', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity:  unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockChangeTitreUseCase.execute(
        nom: any(named: 'nom'),
        indexGestion: any(named: 'indexGestion'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changeTitre(
        nom: 'nouveauNom',
        indexGestion: 0,
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockChangeTitreUseCase.execute(
        nom: 'nouveauNom',
        indexGestion: 0,
        listMontantUniverselle: listMontantUniverselle,
      )).called(1);
    });
  });

  group('changeIcons', () {
    test('should change icons of MontantUniverselle using use case', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity: unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockChangeIconsUseCase.execute(
        icons: any(named: 'icons'),
        indexGestion: any(named: 'indexGestion'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changeIcons(
        icons: 2,
        indexGestion: 0,
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockChangeIconsUseCase.execute(
        icons: 2,
        indexGestion: 0,
        listMontantUniverselle: listMontantUniverselle,
      )).called(1);
    });
  });

  group('toggleActiveMontantUniverselle', () {
    test('should toggle active state of MontantUniverselle using use case', () async {
      // Arrange
      final listMontantUniverselle = [
        MontantUniverselle(unity:  unity_Montant_universelle.ChargeFixe, id: 'id1', montant: 100.0, nom: 'nom1', descriptionUniverselle: [], achat: [], previsionsTotal: 0, icones: 1),
      ];

      when(() => mockToggleActiveUseCase.execute(
        index: any(named: 'index'),
        listMontantUniverselle: any(named: 'listMontantUniverselle'),
      )).thenAnswer((_) async {});

      // Act
      await controller.toggleActiveMontantUniverselle(
        index: 0,
        listMontantUniverselle: listMontantUniverselle,
      );

      // Assert
      verify(() => mockToggleActiveUseCase.execute(
        index: 0,
        listMontantUniverselle: listMontantUniverselle,
      )).called(1);
    });
  });

  group('saveMontantUniverselle', () {
    test('should save MontantUniverselle list using use case', () async {
      // Arrange
      final listMontantUniverselle = [
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

      when(() => mockSaveUseCase.execute(any<List<MontantUniverselle>>(), any<bool>()))
          .thenAnswer((_) async => true);

      // Act
      final result = await controller.saveMontantUniverselle(listMontantUniverselle, remove: true);

      // Assert
      expect(result, true);
      verify(() => mockSaveUseCase.execute(listMontantUniverselle, true)).called(1);
    });
  });
}
