import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuelle_montant_univ_live_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockSaveGestionMensuelUseCase extends Mock
    implements SaveGestionMensuelUseCase {}

void main() {
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late RemoveGestionMensuelleMontantUnivLiveUseCase
      removeGestionMensuelleMontantUnivLiveUseCase;

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
    removeGestionMensuelleMontantUnivLiveUseCase =
        RemoveGestionMensuelleMontantUnivLiveUseCase(
            mockSaveGestionMensuelUseCase);
  });

  test(
      'Should move MontantUniverselleLive to MontantUniverselle and save the list when validation is true',
      () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [],
        montantUniverselleLive: [
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
      ),
    ];

    when(() => mockSaveGestionMensuelUseCase.execute(
          any<List<GestionMensuel>>(),
          remove: any(named: 'remove'),
        )).thenAnswer((_) async => Future.value(false));

    // Act
    await removeGestionMensuelleMontantUnivLiveUseCase.execute(
      validation: true,
      indexGestionMensuel: 0,
      indexGestionMensMontanUniv: 0,
      idGestionMensMontanUniv: 'id1',
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle.length, 1);
    expect(listGestionMensuel[0].montantUniverselleLive.isEmpty, true);
    verify(() => mockSaveGestionMensuelUseCase.execute(
          any<List<GestionMensuel>>(),
          remove: false,
        )).called(1);
  });

  test(
      'Should remove MontantUniverselleLive without moving to MontantUniverselle when validation is false',
      () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [],
        montantUniverselleLive: [
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
      ),
    ];

    when(() => mockSaveGestionMensuelUseCase.execute(
          any<List<GestionMensuel>>(),
          remove: any(named: 'remove'),
        )).thenAnswer((_) async => Future.value(false));

    // Act
    await removeGestionMensuelleMontantUnivLiveUseCase.execute(
      validation: false,
      indexGestionMensuel: 0,
      indexGestionMensMontanUniv: 0,
      idGestionMensMontanUniv: 'id1',
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle.isEmpty, true);
    expect(listGestionMensuel[0].montantUniverselleLive.isEmpty, true);
    verify(() => mockSaveGestionMensuelUseCase.execute(
          any<List<GestionMensuel>>(),
          remove: false,
        )).called(1);
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
        montantUniverselleLive: [
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
      ),
    ];

    when(() => mockSaveGestionMensuelUseCase.execute(
          any<List<GestionMensuel>>(),
          remove: any(named: 'remove'),
        )).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await removeGestionMensuelleMontantUnivLiveUseCase.execute(
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
