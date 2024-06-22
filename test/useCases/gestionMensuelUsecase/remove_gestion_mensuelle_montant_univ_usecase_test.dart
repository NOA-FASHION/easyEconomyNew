import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuelle_montant_univ_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockSaveGestionMensuelleMontantUnivUseCase extends Mock implements SaveGestionMensuelleMontantUnivUseCase {}

void main() {
  late MockSaveGestionMensuelleMontantUnivUseCase mockSaveGestionMensuelleMontantUnivUseCase;
  late RemoveGestionMensuelleMontantUnivUseCase removeGestionMensuelleMontantUnivUseCase;

  setUpAll(() {
    registerFallbackValue(GestionMensuel(
      idGestion: 'idGestion',
      nom: 'nom',
      mois: 'mois',
      tendance: 'tendance',
      montantUniverselle: [],
      montantUniverselleLive: [],
    ));
    registerFallbackValue(MontantUniverselle(
      unity: unity_Montant_universelle.ChargeFixe,
      id: 'id',
      montant: 0,
      nom: 'nom',
      descriptionUniverselle: [],
      achat: [],
      previsionsTotal: 0,
      icones: 0,
    ));
  });

  setUp(() {
    mockSaveGestionMensuelleMontantUnivUseCase = MockSaveGestionMensuelleMontantUnivUseCase();
    removeGestionMensuelleMontantUnivUseCase = RemoveGestionMensuelleMontantUnivUseCase(mockSaveGestionMensuelleMontantUnivUseCase);
  });

  test('Should move MontantUniverselle to MontantUniverselleLive and save the list when validation is true', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [
          MontantUniverselle(
             unity: unity_Montant_universelle.ChargeFixe,
            id: 'id1',
            montant: 100,
            nom: 'nom1',
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSaveGestionMensuelleMontantUnivUseCase.execute(
      remove: any(named: 'remove'),
      idGestionMensMontanUniv: any(named: 'idGestionMensMontanUniv'),
      listGestionMensuel: any<List<GestionMensuel>>(named: 'listGestionMensuel'),
    )).thenAnswer((_) async => Future.value(false));

    // Act
    await removeGestionMensuelleMontantUnivUseCase.execute(
      validation: true,
      indexGestionMensuel: 0,
      indexGestionMensMontanUniv: 0,
      idGestionMensMontanUniv: 'id1',
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselleLive.length, 1);
    expect(listGestionMensuel[0].montantUniverselle.isEmpty, true);
    verify(() => mockSaveGestionMensuelleMontantUnivUseCase.execute(
      remove: true,
      idGestionMensMontanUniv: 'id1',
      listGestionMensuel: any<List<GestionMensuel>>(named: 'listGestionMensuel'),
    )).called(1);
  });

  test('Should remove MontantUniverselle without moving to MontantUniverselleLive when validation is false', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [
          MontantUniverselle(
             unity: unity_Montant_universelle.ChargeFixe,
            id: 'id1',
            montant: 100,
            nom: 'nom1',
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSaveGestionMensuelleMontantUnivUseCase.execute(
      remove: any(named: 'remove'),
      idGestionMensMontanUniv: any(named: 'idGestionMensMontanUniv'),
      listGestionMensuel: any<List<GestionMensuel>>(named: 'listGestionMensuel'),
    )).thenAnswer((_) async => Future.value(false));

    // Act
    await removeGestionMensuelleMontantUnivUseCase.execute(
      validation: false,
      indexGestionMensuel: 0,
      indexGestionMensMontanUniv: 0,
      idGestionMensMontanUniv: 'id1',
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselleLive.isEmpty, true);
    expect(listGestionMensuel[0].montantUniverselle.isEmpty, true);
    verify(() => mockSaveGestionMensuelleMontantUnivUseCase.execute(
      remove: true,
      idGestionMensMontanUniv: 'id1',
      listGestionMensuel: any<List<GestionMensuel>>(named: 'listGestionMensuel'),
    )).called(1);
  });

  test('Should handle exception from saveGestionMensuelleMontantUnivUseCase', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [
          MontantUniverselle(
             unity: unity_Montant_universelle.ChargeFixe,
            id: 'id1',
            montant: 100,
            nom: 'nom1',
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSaveGestionMensuelleMontantUnivUseCase.execute(
      remove: any(named: 'remove'),
      idGestionMensMontanUniv: any(named: 'idGestionMensMontanUniv'),
      listGestionMensuel: any<List<GestionMensuel>>(named: 'listGestionMensuel'),
    )).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await removeGestionMensuelleMontantUnivUseCase.execute(
        validation: true,
        indexGestionMensuel: 0,
        indexGestionMensMontanUniv: 0,
        idGestionMensMontanUniv: 'id1',
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
