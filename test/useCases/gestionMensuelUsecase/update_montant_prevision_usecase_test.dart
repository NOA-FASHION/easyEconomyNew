import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/update_montant_prevision_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';

class MockCalculateTotalPrevisionUseCase extends Mock implements CalculateTotalPrevisionUseCase {}

class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}

void main() {
  late MockCalculateTotalPrevisionUseCase mockCalculateTotalPrevisionUseCase;
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late UpdateMontantPrevisionUseCase updateMontantPrevisionUseCase;

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
    registerFallbackValue(DesciprtionUniverselle(
      previsions: 10.0,
      echeance: 2,
      nombreEcheance: 3,
      id: '1',
      name: 'test',
      adresseImage: '',
      description: unity_description.tache,
      commentaire: '',
    ));
  });

  setUp(() {
    mockCalculateTotalPrevisionUseCase = MockCalculateTotalPrevisionUseCase();
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    updateMontantPrevisionUseCase = UpdateMontantPrevisionUseCase(
      mockCalculateTotalPrevisionUseCase,
      mockSaveGestionMensuelUseCase,
    );
  });

  test('Should update montant and save the list when previsions > 0 and achat is empty', () async {
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
            montant: 0,
            nom: 'nom1',
            descriptionUniverselle: [
              DesciprtionUniverselle(
                previsions: 100.0,
                echeance: 2,
                nombreEcheance: 3,
                id: '1',
                name: 'desc1',
                adresseImage: '',
                description: unity_description.tache,
                commentaire: '',
              ),
            ],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockCalculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: any(named: 'indexGestionMensuel'),
      indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
      listGestionMensuel: any(named: 'listGestionMensuel'),
    )).thenReturn(100.0);

    when(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: any(named: 'remove'),
    )).thenAnswer((_) async => true);

    // Act
    await updateMontantPrevisionUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle[0].montant, 100.0);
    verify(() => mockCalculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    )).called(1);
    verify(() => mockSaveGestionMensuelUseCase.execute(
      listGestionMensuel,
      remove: false,
    )).called(1);
  });

  test('Should not update montant or save the list when previsions <= 0 or achat is not empty', () async {
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
            montant: 0,
            nom: 'nom1',
            descriptionUniverselle: [
              DesciprtionUniverselle(
                previsions: 0.0,
                echeance: 2,
                nombreEcheance: 3,
                id: '1',
                name: 'desc1',
                adresseImage: '',
                description: unity_description.tache,
                commentaire: '',
              ),
            ],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    // Act
    await updateMontantPrevisionUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle[0].montant, 0);
    verifyNever(() => mockCalculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: any(named: 'indexGestionMensuel'),
      indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
      listGestionMensuel: any(named: 'listGestionMensuel'),
    ));
    verifyNever(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: any(named: 'remove'),
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
        montantUniverselle: [
          MontantUniverselle(
            unity: unity_Montant_universelle.ChargeFixe,
            id: 'id1',
            montant: 0,
            nom: 'nom1',
            descriptionUniverselle: [
              DesciprtionUniverselle(
                previsions: 100.0,
                echeance: 2,
                nombreEcheance: 3,
                id: '1',
                name: 'desc1',
                adresseImage: '',
                description: unity_description.tache,
                commentaire: '',
              ),
            ],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockCalculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: any(named: 'indexGestionMensuel'),
      indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
      listGestionMensuel: any(named: 'listGestionMensuel'),
    )).thenReturn(100.0);

    when(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: any(named: 'remove'),
    )).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await updateMontantPrevisionUseCase.execute(
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
