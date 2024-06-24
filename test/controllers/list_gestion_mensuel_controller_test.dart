import 'dart:convert';

import 'package:easyeconomy/controllers/list_gestion_mensuel_controller.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_achat_total_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_description_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_live_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_gestion_mensuel_montant_univ_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/toggle_active_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_description_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_live_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_description_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuelle_montant_univ_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/update_montant_achat_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/update_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/change_icons_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/change_prix_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/change_titre_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/services/gestionMensuelServices/gestion_mensuel_get_data_sharedpreferencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:easyeconomy/mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart';

// Mocks
class MockGestionMensuelGetDataSharedpreferencies extends Mock implements GestionMensuelGetDataSharedpreferencies {}
class MockAddAchatTotalUseCase extends Mock implements AddAchatTotalUseCase {}
class MockAddDescriptionGestionUseCase extends Mock implements AddDescriptionGestionUseCase {}
class MockAddGestionMensuelMontantUnivLiveUseCase extends Mock implements AddGestionMensuelMontantUnivLiveUseCase {}
class MockAddGestionMensuelMontantUnivUseCase extends Mock implements AddGestionMensuelMontantUnivUseCase {}
class MockCalculateTotalAchatUseCase extends Mock implements CalculateTotalAchatUseCase {}
class MockCalculateTotalPrevisionUseCase extends Mock implements CalculateTotalPrevisionUseCase {}
class MockAddMontantGestionUseCase extends Mock implements AddMontantGestionUseCase {}
class MockToggleActiveGestionMensuelUseCase extends Mock implements ToggleActiveGestionMensuelUseCase {}
class MockLoadGestionMensuelUseCase extends Mock implements LoadGestionMensuelUseCase {}
class MockRemoveGestionDescriptionGestionUseCase extends Mock implements RemoveGestionDescriptionGestionUseCase {}
class MockRemoveGestionMensuelUseCase extends Mock implements RemoveGestionMensuelUseCase {}
class MockRemoveGestionMensuelleMontantUnivLiveUseCase extends Mock implements RemoveGestionMensuelleMontantUnivLiveUseCase {}
class MockRemoveGestionMensuelleMontantUnivUseCase extends Mock implements RemoveGestionMensuelleMontantUnivUseCase {}
class MockSaveDescriptionGestionUseCase extends Mock implements SaveDescriptionGestionUseCase {}
class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}
class MockSaveGestionMensuelleMontantUnivUseCase extends Mock implements SaveGestionMensuelleMontantUnivUseCase {}
class MockUpdateMontantAchatUseCase extends Mock implements UpdateMontantAchatUseCase {}
class MockUpdateMontantPrevisionUseCase extends Mock implements UpdateMontantPrevisionUseCase {}
class MockChangeIconsGestionMensuelUseCase extends Mock implements ChangeIconsGestionMensuelUseCase {}
class MockChangePrixGestionMensuelUseCase extends Mock implements ChangePrixGestionMensuelUseCase {}
class MockChangeTitreGestionMensuelUseCase extends Mock implements ChangeTitreGestionMensuelUseCase {}
class MockMapperListGestionMensuelJsonToModelUseCase extends Mock implements MapperListGestionMensuelJsonToModelUseCase {}

void main() {
  late ListGestionMensuelController controller;
  late MockGestionMensuelGetDataSharedpreferencies mockGetDataSharedPreferences;
  late MockAddAchatTotalUseCase mockAddAchatTotalUseCase;
  late MockAddDescriptionGestionUseCase mockAddDescriptionGestionUseCase;
  late MockAddGestionMensuelMontantUnivLiveUseCase mockAddGestionMensuelMontantUnivLiveUseCase;
  late MockAddGestionMensuelMontantUnivUseCase mockAddGestionMensuelMontantUnivUseCase;
  late MockCalculateTotalAchatUseCase mockCalculateTotalAchatUseCase;
  late MockCalculateTotalPrevisionUseCase mockCalculateTotalPrevisionUseCase;
  late MockAddMontantGestionUseCase mockAddMontantGestionUseCase;
  late MockToggleActiveGestionMensuelUseCase mockToggleActiveGestionMensuelUseCase;
  late MockLoadGestionMensuelUseCase mockLoadGestionMensuelUseCase;
  late MockRemoveGestionDescriptionGestionUseCase mockRemoveGestionDescriptionGestionUseCase;
  late MockRemoveGestionMensuelUseCase mockRemoveGestionMensuelUseCase;
  late MockRemoveGestionMensuelleMontantUnivLiveUseCase mockRemoveGestionMensuelleMontantUnivLiveUseCase;
  late MockRemoveGestionMensuelleMontantUnivUseCase mockRemoveGestionMensuelleMontantUnivUseCase;
  late MockSaveDescriptionGestionUseCase mockSaveDescriptionGestionUseCase;
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late MockSaveGestionMensuelleMontantUnivUseCase mockSaveGestionMensuelleMontantUnivUseCase;
  late MockUpdateMontantAchatUseCase mockUpdateMontantAchatUseCase;
  late MockUpdateMontantPrevisionUseCase mockUpdateMontantPrevisionUseCase;
  late MockChangeIconsGestionMensuelUseCase mockChangeIconsGestionMensuelUseCase;
  late MockChangePrixGestionMensuelUseCase mockChangePrixGestionMensuelUseCase;
  late MockChangeTitreGestionMensuelUseCase mockChangeTitreGestionMensuelUseCase;
  late MockMapperListGestionMensuelJsonToModelUseCase mockMapper;

  setUp(() {
    mockGetDataSharedPreferences = MockGestionMensuelGetDataSharedpreferencies();
    mockAddAchatTotalUseCase = MockAddAchatTotalUseCase();
    mockAddDescriptionGestionUseCase = MockAddDescriptionGestionUseCase();
    mockAddGestionMensuelMontantUnivLiveUseCase = MockAddGestionMensuelMontantUnivLiveUseCase();
    mockAddGestionMensuelMontantUnivUseCase = MockAddGestionMensuelMontantUnivUseCase();
    mockCalculateTotalAchatUseCase = MockCalculateTotalAchatUseCase();
    mockCalculateTotalPrevisionUseCase = MockCalculateTotalPrevisionUseCase();
    mockAddMontantGestionUseCase = MockAddMontantGestionUseCase();
    mockToggleActiveGestionMensuelUseCase = MockToggleActiveGestionMensuelUseCase();
    mockLoadGestionMensuelUseCase = MockLoadGestionMensuelUseCase();
    mockRemoveGestionDescriptionGestionUseCase = MockRemoveGestionDescriptionGestionUseCase();
    mockRemoveGestionMensuelUseCase = MockRemoveGestionMensuelUseCase();
    mockRemoveGestionMensuelleMontantUnivLiveUseCase = MockRemoveGestionMensuelleMontantUnivLiveUseCase();
    mockRemoveGestionMensuelleMontantUnivUseCase = MockRemoveGestionMensuelleMontantUnivUseCase();
    mockSaveDescriptionGestionUseCase = MockSaveDescriptionGestionUseCase();
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    mockSaveGestionMensuelleMontantUnivUseCase = MockSaveGestionMensuelleMontantUnivUseCase();
    mockUpdateMontantAchatUseCase = MockUpdateMontantAchatUseCase();
    mockUpdateMontantPrevisionUseCase = MockUpdateMontantPrevisionUseCase();
    mockChangeIconsGestionMensuelUseCase = MockChangeIconsGestionMensuelUseCase();
    mockChangePrixGestionMensuelUseCase = MockChangePrixGestionMensuelUseCase();
    mockChangeTitreGestionMensuelUseCase = MockChangeTitreGestionMensuelUseCase();
    mockMapper = MockMapperListGestionMensuelJsonToModelUseCase();

    controller = ListGestionMensuelController(
      mockGetDataSharedPreferences,
      mockMapper,
      mockLoadGestionMensuelUseCase,
      mockSaveGestionMensuelUseCase,
      mockAddMontantGestionUseCase,
      mockRemoveGestionMensuelUseCase,
      mockCalculateTotalPrevisionUseCase,
      mockCalculateTotalAchatUseCase,
      mockUpdateMontantPrevisionUseCase,
      mockUpdateMontantAchatUseCase,
      mockAddAchatTotalUseCase,
      mockAddDescriptionGestionUseCase,
      mockAddGestionMensuelMontantUnivUseCase,
      mockAddGestionMensuelMontantUnivLiveUseCase,
      mockRemoveGestionMensuelleMontantUnivLiveUseCase,
      mockSaveDescriptionGestionUseCase,
      mockSaveGestionMensuelleMontantUnivUseCase,
      mockRemoveGestionDescriptionGestionUseCase,
      mockRemoveGestionMensuelleMontantUnivUseCase,
      mockChangePrixGestionMensuelUseCase,
      mockChangeTitreGestionMensuelUseCase,
      mockChangeIconsGestionMensuelUseCase,
      mockToggleActiveGestionMensuelUseCase,
    );
  });

  group('ListGestionMensuelController Tests', () {
    test('Should load data and map to GestionMensuel list', () async {
      // Arrange
      final jsonList = [
        {
          'idGestion': '1',
          'nom': 'Gestion1',
          'mois': 'Jan',
          'tendance': 'stable',
          'montantUniverselle': [],
          'montantUniverselleLive': [],
        },
      ];
      final dataList = jsonList.map((e) => jsonEncode(e)).toList();
      when(() => mockGetDataSharedPreferences.execute()).thenAnswer((_) async => dataList);
      when(() => mockLoadGestionMensuelUseCase.execute(any())).thenAnswer((_) async => [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ]);

      // Act
      final result = await controller.loadData();

      // Assert
      expect(result.length, 1);
      expect(result[0].nom, 'Gestion1');
    });

    test('Should add MontantUniverselle to GestionMensuel', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockAddMontantGestionUseCase.execute(
        icones: any(named: 'icones'),
        nom: any(named: 'nom'),
        montant: any(named: 'montant'),
        id: any(named: 'id'),
        unity: any(named: 'unity'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.addMontanUniverselle(
        icones: 1,
        nom: 'Test',
        montant: 100.0,
        id: '1',
        unity: 'TestUnity',
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockAddMontantGestionUseCase.execute(
        icones: 1,
        nom: 'Test',
        montant: 100.0,
        id: '1',
        unity: 'TestUnity',
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should remove GestionMensuelle', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockRemoveGestionMensuelUseCase.execute(
        index: any(named: 'index'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.removeGestionMensuelle(
        index: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockRemoveGestionMensuelUseCase.execute(
        index: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should calculate total prevision', () {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockCalculateTotalPrevisionUseCase.execute(
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenReturn(100.0);

      // Act
      final result = controller.calculateTotalPrevision(0, 0, listGestionMensuel);

      // Assert
      expect(result, 100.0);
    });

    test('Should calculate total achat', () {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockCalculateTotalAchatUseCase.execute(
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenReturn(200.0);

      // Act
      final result = controller.calculateTotalAchat(0, 0, listGestionMensuel);

      // Assert
      expect(result, 200.0);
    });

    test('Should update montant prevision', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockUpdateMontantPrevisionUseCase.execute(
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.updateMontantPrevision(0, 0, listGestionMensuel);

      // Assert
      verify(() => mockUpdateMontantPrevisionUseCase.execute(
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should update montant achat', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockUpdateMontantAchatUseCase.execute(
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.updateMontantAchat(0, 0, listGestionMensuel);

      // Assert
      verify(() => mockUpdateMontantAchatUseCase.execute(
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should add achat total', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockAddAchatTotalUseCase.execute(
        indexGestion: any(named: 'indexGestion'),
        indexGestionLive: any(named: 'indexGestionLive'),
        indexGestionDescription: any(named: 'indexGestionDescription'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.addAchatTotal(
        indexGestion: 0,
        indexGestionLive: 0,
        indexGestionDescription: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockAddAchatTotalUseCase.execute(
        indexGestion: 0,
        indexGestionLive: 0,
        indexGestionDescription: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should add description gestion', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockAddDescriptionGestionUseCase.execute(
        achat: any(named: 'achat'),
        previsions: any(named: 'previsions'),
        echeance: any(named: 'echeance'),
        nombreEcheance: any(named: 'nombreEcheance'),
        id: any(named: 'id'),
        adresseImage: any(named: 'adresseImage'),
        name: any(named: 'name'),
        commentaire: any(named: 'commentaire'),
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
        description: any(named: 'description'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.addDescriptionGestion(
        achat: [],
        previsions: 100.0,
        echeance: 1.0,
        nombreEcheance: 12,
        id: '1',
        adresseImage: 'image.png',
        name: 'Test',
        commentaire: 'Test Commentaire',
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        description: 'description',
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockAddDescriptionGestionUseCase.execute(
        achat: [],
        previsions: 100.0,
        echeance: 1.0,
        nombreEcheance: 12,
        id: '1',
        adresseImage: 'image.png',
        name: 'Test',
        commentaire: 'Test Commentaire',
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        description: 'description',
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should add gestion mensuel montant univ', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockAddGestionMensuelMontantUnivUseCase.execute(
        icones: any(named: 'icones'),
        nom: any(named: 'nom'),
        montant: any(named: 'montant'),
        id: any(named: 'id'),
        unity: any(named: 'unity'),
        index: any(named: 'index'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.addGestionMensuelMontantUniv(
        icones: 1,
        nom: 'Test',
        montant: 100.0,
        id: '1',
        unity: 'TestUnity',
        index: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockAddGestionMensuelMontantUnivUseCase.execute(
        icones: 1,
        nom: 'Test',
        montant: 100.0,
        id: '1',
        unity: 'TestUnity',
        index: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should add gestion mensuel montant univ live', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockAddGestionMensuelMontantUnivLiveUseCase.execute(
        icones: any(named: 'icones'),
        nom: any(named: 'nom'),
        montant: any(named: 'montant'),
        id: any(named: 'id'),
        unity: any(named: 'unity'),
        index: any(named: 'index'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.addGestionMensuelMontantUnivLive(
        icones: 1,
        nom: 'Test',
        montant: 100.0,
        id: '1',
        unity: 'TestUnity',
        index: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockAddGestionMensuelMontantUnivLiveUseCase.execute(
        icones: 1,
        nom: 'Test',
        montant: 100.0,
        id: '1',
        unity: 'TestUnity',
        index: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should remove gestion mensuelle montant univ live', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockRemoveGestionMensuelleMontantUnivLiveUseCase.execute(
        validation: any(named: 'validation'),
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensMontanUniv: any(named: 'indexGestionMensMontanUniv'),
        idGestionMensMontanUniv: any(named: 'idGestionMensMontanUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.removeGestionMensuelleMontantUnivLive(
        validation: true,
        indexGestionMensuel: 0,
        indexGestionMensMontanUniv: 0,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockRemoveGestionMensuelleMontantUnivLiveUseCase.execute(
        validation: true,
        indexGestionMensuel: 0,
        indexGestionMensMontanUniv: 0,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should save description gestion', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockSaveDescriptionGestionUseCase.execute(
        remove: any(named: 'remove'),
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async => true);

      // Act
      final result = await controller.saveDescriptionGestion(
        remove: true,
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      expect(result, true);
      verify(() => mockSaveDescriptionGestionUseCase.execute(
        remove: true,
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should save gestion mensuelle montant univ', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockSaveGestionMensuelleMontantUnivUseCase.execute(
        remove: any(named: 'remove'),
        idGestionMensMontanUniv: any(named: 'idGestionMensMontanUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async => true);

      // Act
      final result = await controller.saveGestionMensuelleMontantUniv(
        remove: true,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      expect(result, true);
      verify(() => mockSaveGestionMensuelleMontantUnivUseCase.execute(
        remove: true,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should remove gestion description gestion', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockRemoveGestionDescriptionGestionUseCase.execute(
        index: any(named: 'index'),
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
        idGestionMensMontanUniv: any(named: 'idGestionMensMontanUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.removeGestionDescriptionGestion(
        index: 0,
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockRemoveGestionDescriptionGestionUseCase.execute(
        index: 0,
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should remove gestion mensuelle montant univ', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockRemoveGestionMensuelleMontantUnivUseCase.execute(
        validation: any(named: 'validation'),
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestionMensMontanUniv: any(named: 'indexGestionMensMontanUniv'),
        idGestionMensMontanUniv: any(named: 'idGestionMensMontanUniv'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.removeGestionMensuelleMontantUniv(
        validation: true,
        indexGestionMensuel: 0,
        indexGestionMensMontanUniv: 0,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockRemoveGestionMensuelleMontantUnivUseCase.execute(
        validation: true,
        indexGestionMensuel: 0,
        indexGestionMensMontanUniv: 0,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should change prix gestion mensuel', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockChangePrixGestionMensuelUseCase.execute(
        montant: any(named: 'montant'),
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestion: any(named: 'indexGestion'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changePrixGestionMensuel(
        montant: '100.0',
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockChangePrixGestionMensuelUseCase.execute(
        montant: '100.0',
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should change titre gestion mensuel', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockChangeTitreGestionMensuelUseCase.execute(
        nom: any(named: 'nom'),
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestion: any(named: 'indexGestion'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changeTitreGestionMensuel(
        nom: 'Test',
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockChangeTitreGestionMensuelUseCase.execute(
        nom: 'Test',
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should change icons gestion mensuel', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockChangeIconsGestionMensuelUseCase.execute(
        icons: any(named: 'icons'),
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestion: any(named: 'indexGestion'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.changeIconsGestionMensuel(
        icons: 1,
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockChangeIconsGestionMensuelUseCase.execute(
        icons: 1,
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should toggle active gestion mensuel', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockToggleActiveGestionMensuelUseCase.execute(
        indexGestionMensuel: any(named: 'indexGestionMensuel'),
        indexGestion: any(named: 'indexGestion'),
        listGestionMensuel: any(named: 'listGestionMensuel'),
      )).thenAnswer((_) async {});

      // Act
      await controller.toggleActiveGestionMensuel(
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      );

      // Assert
      verify(() => mockToggleActiveGestionMensuelUseCase.execute(
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      )).called(1);
    });

    test('Should save gestion mensuelle', () async {
      // Arrange
      final listGestionMensuel = [
        GestionMensuel(
          idGestion: '1',
          nom: 'Gestion1',
          mois: 'Jan',
          tendance: 'stable',
          montantUniverselle: [],
          montantUniverselleLive: [],
        )
      ];
      when(() => mockSaveGestionMensuelUseCase.execute(
        any<List<GestionMensuel>>(),
        remove: any(named: 'remove'),
      )).thenAnswer((_) async => true);

      // Act
      final result = await controller.saveGestionMensuelle(
        listGestionMensuel: listGestionMensuel,
        remove: true,
      );

      // Assert
      expect(result, true);
      verify(() => mockSaveGestionMensuelUseCase.execute(
        listGestionMensuel,
        remove: true,
      )).called(1);
    });
  });
}
