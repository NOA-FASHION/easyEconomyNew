// import 'package:easyeconomy/models/easy_economy_models.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:easyeconomy/controllers/easy_controller.dart';
// import 'package:easyeconomy/controllers/list_gestion_mensuel_controller.dart';
// import 'package:easyeconomy/controllers/list_montant_prevision_controller.dart';
// import 'package:easyeconomy/controllers/list_montant_universelle_controller.dart';
// import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
// import 'package:easyeconomy/useCases/choix_desciption_upload_usecase.dart';
// import 'package:easyeconomy/useCases/choix_description_enum_usecase.dart';
// import 'package:easyeconomy/useCases/generate_gestion_mensuel_prevision_usecase.dart';
// import 'package:easyeconomy/useCases/read_content_usecase.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MockListGestionMensuelController extends Mock implements ListGestionMensuelController {}
// class MockListMontantUniverselleController extends Mock implements ListMontantUniverselleController {}
// class MockListMontantPrevisionController extends Mock implements ListMontantPrevisionController {}
// class MockChoixDesciptionDetailsFinanceEnumUseCase extends Mock implements ChoixDesciptionDetailsFinanceEnumUseCase {}
// class MockChoixDesciptionUploadUseCase extends Mock implements ChoixDesciptionUploadUseCase {}
// class MockChoixDesciptionEnumUseCase extends Mock implements ChoixDesciptionEnumUseCase {}
// class MockGenerateGestionMensuelPrevisionUseCase extends Mock implements GenerateGestionMensuelPrevisionUseCase {}
// class MockReadContentUseCase extends Mock implements ReadContentUseCase {}
// class MockSharedPreferences extends Mock implements SharedPreferences {}

// void main() {
//   late EasyController controller;
//   late MockListGestionMensuelController mockListGestionMensuelController;
//   late MockListMontantUniverselleController mockListMontantUniverselleController;
//   late MockListMontantPrevisionController mockListMontantPrevisionController;
//   late MockChoixDesciptionDetailsFinanceEnumUseCase mockChoixDesciptionDetailsFinanceEnumUseCase;
//   late MockChoixDesciptionUploadUseCase mockChoixDesciptionUploadUseCase;
//   late MockChoixDesciptionEnumUseCase mockChoixDesciptionEnumUseCase;
//   late MockGenerateGestionMensuelPrevisionUseCase mockGenerateGestionMensuelPrevisionUseCase;
//   late MockReadContentUseCase mockReadContentUseCase;
//   late MockSharedPreferences mockSharedPreferences;

//   setUp(() {
//     mockListGestionMensuelController = MockListGestionMensuelController();
//     mockListMontantUniverselleController = MockListMontantUniverselleController();
//     mockListMontantPrevisionController = MockListMontantPrevisionController();
//     mockChoixDesciptionDetailsFinanceEnumUseCase = MockChoixDesciptionDetailsFinanceEnumUseCase();
//     mockChoixDesciptionUploadUseCase = MockChoixDesciptionUploadUseCase();
//     mockChoixDesciptionEnumUseCase = MockChoixDesciptionEnumUseCase();
//     mockGenerateGestionMensuelPrevisionUseCase = MockGenerateGestionMensuelPrevisionUseCase();
//     mockReadContentUseCase = MockReadContentUseCase();
//     mockSharedPreferences = MockSharedPreferences();

//     controller = EasyController(
//       mockListGestionMensuelController,
//       mockSharedPreferences,
//       mockListMontantUniverselleController,
//       mockChoixDesciptionDetailsFinanceEnumUseCase,
//       mockChoixDesciptionEnumUseCase,
//       mockListMontantPrevisionController,
//       mockGenerateGestionMensuelPrevisionUseCase,
//       mockReadContentUseCase,
//       mockChoixDesciptionUploadUseCase,
//     );
//   });

//   group('Tests pour EasyController', () {
//     // test('Doit charger les données Economy', () async {
//     //   when(() => mockSharedPreferences.getString(any())).thenReturn(null);
//     //   when(() => mockListGestionMensuelController.loadData()).thenAnswer((_) async => []);
//     //   when(() => mockListMontantUniverselleController.loadData()).thenAnswer((_) async => []);
//     //   when(() => mockListMontantPrevisionController.loadData()).thenAnswer((_) async => []);
//     //   when(() => mockGenerateGestionMensuelPrevisionUseCase.execute(any())).thenReturn([]);

//     //   await controller.;

//     //   verify(() => mockSharedPreferences.getString(any())).called(1);
//     //   verify(() => mockListGestionMensuelController.loadData()).called(1);
//     //   verify(() => mockListMontantUniverselleController.loadData()).called(1);
//     //   verify(() => mockListMontantPrevisionController.loadData()).called(1);
//     //   verify(() => mockGenerateGestionMensuelPrevisionUseCase.execute(any())).called(1);
//     // });

//     test('Doit ajouter un Montant Universelle', () async {
//       final listMontantUniverselle = <MontantUniverselle>[];

//       when(() => mockListMontantUniverselleController.addMontanUniverselle(
//         icones: any(named: 'icones'),
//         nom: any(named: 'nom'),
//         montant: any(named: 'montant'),
//         id: any(named: 'id'),
//         unity: any(named: 'unity'),
//         listMontantUniverselle: any(named: 'listMontantUniverselle'),
//       )).thenAnswer((_) async {});

//        controller.addMontanUniverselle(
//         icones: 1,
//         nom: 'Test',
//         montant: 100.0,
//         id: '1',
//         unity: 'TestUnity',
//       );

//       verify(() => mockListMontantUniverselleController.addMontanUniverselle(
//         icones: 1,
//         nom: 'Test',
//         montant: 100.0,
//         id: '1',
//         unity: 'TestUnity',
//         listMontantUniverselle: any(named: 'listMontantUniverselle'),
//       )).called(1);
//     });

//     test('Doit supprimer un Montant Universelle', () async {
//       final listMontantUniverselle = <MontantUniverselle>[];

//       when(() => mockListMontantUniverselleController.removeMontantUniverselle(
//         index: any(named: 'index'),
//         listMontantUniverselle: any(named: 'listMontantUniverselle'),
//       )).thenAnswer((_) async {});

//        controller.removeMontantUniverselle(index: 0);

//       verify(() => mockListMontantUniverselleController.removeMontantUniverselle(
//         index: 0,
//         listMontantUniverselle: any(named: 'listMontantUniverselle'),
//       )).called(1);
//     });

//     // test('Doit changer le Prix', () async {
//     //   final listMontantUniverselle = <MontantUniverselle>[];

//     //   when(() => mockListMontantUniverselleController.changePrix(
//     //     montant: any(named: 'montant'),
//     //     indexGestion: any(named: 'indexGestion'),
//     //     listMontantUniverselle: any(named: 'listMontantUniverselle'),
//     //   )).thenAnswer((_) async {});

//     //   await controller.changePrix(montant: '100.0', indexGestion: 0);

//     //   verify(() => mockListMontantUniverselleController.changePrix(
//     //     montant: '100.0',
//     //     indexGestion: 0,
//     //     listMontantUniverselle: any(named: 'listMontantUniverselle'),
//     //   )).called(1);
//     // });

//     test('Doit activer ou désactiver un Montant Universelle', () async {
//       final listMontantUniverselle = <MontantUniverselle>[];

//       when(() => mockListMontantUniverselleController.toggleActiveMontantUniverselle(
//         index: any(named: 'index'),
//         listMontantUniverselle: any(named: 'listMontantUniverselle'),
//       )).thenAnswer((_) async {});

//       await controller.activeListListMontantUniverselle(index: 0);

//       verify(() => mockListMontantUniverselleController.toggleActiveMontantUniverselle(
//         index: 0,
//         listMontantUniverselle: any(named: 'listMontantUniverselle'),
//       )).called(1);
//     });

//     test('Doit ajouter une Description à un Montant Universelle', () async {
//       final listMontantUniverselle = <MontantUniverselle>[];

//       when(() => mockListMontantUniverselleController.addDescriptionMontantUniverselle(
//         achat: any(named: 'achat'),
//         previsions: any(named: 'previsions'),
//         echeance: any(named: 'echeance'),
//         nombreEcheance: any(named: 'nombreEcheance'),
//         id: any(named: 'id'),
//         adresseImage: any(named: 'adresseImage'),
//         name: any(named: 'name'),
//         commentaire: any(named: 'commentaire'),
//         indexChargeFixe: any(named: 'indexChargeFixe'),
//         description: any(named: 'description'),
//         listMontantUniverselle: any(named: 'listMontantUniverselle'),
//       )).thenAnswer((_) async {});

//       await controller.addDescriptionMontaUniv(
//         achat: [],
//         previsions: 100.0,
//         echeance: 1.0,
//         nombreEcheance: 12.0,
//         id: '1',
//         adresseImage: 'image.png',
//         name: 'Test',
//         commentaire: 'Test Commentaire',
//         indexChargeFixe: 0,
//         description: 'description',
//       );

//       verify(() => mockListMontantUniverselleController.addDescriptionMontantUniverselle(
//         achat: [],
//         previsions: 100.0,
//         echeance: 1.0,
//         nombreEcheance: 12.0,
//         id: '1',
//         adresseImage: 'image.png',
//         name: 'Test',
//         commentaire: 'Test Commentaire',
//         indexChargeFixe: 0,
//         description: 'description',
//         listMontantUniverselle: any(named: 'listMontantUniverselle'),
//       )).called(1);
//     });

//     // Autres tests pour les méthodes restantes
//   });
// }
