import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/echeance_passe_montan_unive_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/echeance_passe_montan_unive_valid_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockEcheancePasseMontanUniveValidUseCase extends Mock implements EcheancePasseMontanUniveValidUseCase {}

void main() {
  late MockEcheancePasseMontanUniveValidUseCase mockEcheancePasseMontanUniveValidUseCase;
  late EcheancePasseMontanUniveUseCase echeancePasseMontanUniveUseCase;

  setUpAll(() {
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
    mockEcheancePasseMontanUniveValidUseCase = MockEcheancePasseMontanUniveValidUseCase();
    echeancePasseMontanUniveUseCase = EcheancePasseMontanUniveUseCase(mockEcheancePasseMontanUniveValidUseCase);
  });

  test('Should call EcheancePasseMontanUniveValidUseCase for matching elements', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
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
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id2',
        montant: 200.0,
        nom: 'nom2',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 2,
      ),
    ];

    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: 'idGestion1',
        nom: 'nom1',
        mois: 'mois1',
        tendance: 'tendance1',
        montantUniverselle: [
          MontantUniverselle(
            unity: unity_Montant_universelle.ChargeFixe,
            id: 'id2',
            montant: 200.0,
            nom: 'nom2',
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 2,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockEcheancePasseMontanUniveValidUseCase.execute(index: any(named: 'index'), listMontantUniverselle: any(named: 'listMontantUniverselle'))).thenAnswer((_) async => true);

    // Act
    await echeancePasseMontanUniveUseCase.execute(
      idGestionMensMontantUnv: 'id2',
      indexGestion: 0,
      indexGestionLive: 0,
      listMontantUniverselle: listMontantUniverselle,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    verify(() => mockEcheancePasseMontanUniveValidUseCase.execute(
      index: 1,
      listMontantUniverselle: listMontantUniverselle,
    )).called(1);
  });

  test('Should handle no matching elements gracefully', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
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

    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: 'idGestion1',
        nom: 'nom1',
        mois: 'mois1',
        tendance: 'tendance1',
        montantUniverselle: [
          MontantUniverselle(
            unity: unity_Montant_universelle.ChargeFixe,
            id: 'id2',
            montant: 200.0,
            nom: 'nom2',
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 2,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    // Act
    await echeancePasseMontanUniveUseCase.execute(
      idGestionMensMontantUnv: 'id3',
      indexGestion: 0,
      indexGestionLive: 0,
      listMontantUniverselle: listMontantUniverselle,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    verifyNever(() => mockEcheancePasseMontanUniveValidUseCase.execute(
      index: any(named: 'index'),
      listMontantUniverselle: any(named: 'listMontantUniverselle'),
    ));
  });

  test('Should handle exception from EcheancePasseMontanUniveValidUseCase', () async {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
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
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id2',
        montant: 200.0,
        nom: 'nom2',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0,
        icones: 2,
      ),
    ];

    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: 'idGestion1',
        nom: 'nom1',
        mois: 'mois1',
        tendance: 'tendance1',
        montantUniverselle: [
          MontantUniverselle(
            unity: unity_Montant_universelle.ChargeFixe,
            id: 'id2',
            montant: 200.0,
            nom: 'nom2',
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 2,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockEcheancePasseMontanUniveValidUseCase.execute(index: any(named: 'index'), listMontantUniverselle: any(named: 'listMontantUniverselle'))).thenThrow(Exception('Validation failed'));

    // Act & Assert
    expect(
      () async => await echeancePasseMontanUniveUseCase.execute(
        idGestionMensMontantUnv: 'id2',
        indexGestion: 0,
        indexGestionLive: 0,
        listMontantUniverselle: listMontantUniverselle,
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
