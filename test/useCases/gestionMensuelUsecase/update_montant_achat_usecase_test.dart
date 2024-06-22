import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/update_montant_achat_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';

class MockCalculateTotalAchatUseCase extends Mock implements CalculateTotalAchatUseCase {}

class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}

void main() {
  late MockCalculateTotalAchatUseCase mockCalculateTotalAchatUseCase;
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late UpdateMontantAchatUseCase updateMontantAchatUseCase;

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
    mockCalculateTotalAchatUseCase = MockCalculateTotalAchatUseCase();
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    updateMontantAchatUseCase = UpdateMontantAchatUseCase(
      mockCalculateTotalAchatUseCase,
      mockSaveGestionMensuelUseCase,
    );
  });

  test('Should update montant and save the list when achat is not empty', () async {
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
            descriptionUniverselle: [],
            achat: [100.0, 200.0],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockCalculateTotalAchatUseCase.execute(
      indexGestionMensuel: any(named: 'indexGestionMensuel'),
      indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
      listGestionMensuel: any(named: 'listGestionMensuel'),
    )).thenReturn(300.0);

    when(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: any(named: 'remove'),
    )).thenAnswer((_) async => true);

    // Act
    await updateMontantAchatUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle[0].montant, 300.0);
    verify(() => mockCalculateTotalAchatUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    )).called(1);
    verify(() => mockSaveGestionMensuelUseCase.execute(
      listGestionMensuel,
      remove: false,
    )).called(1);
  });

  test('Should not update montant or save the list when achat is empty', () async {
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
            descriptionUniverselle: [],
            achat: [],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    // Act
    await updateMontantAchatUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle[0].montant, 0);
    verifyNever(() => mockCalculateTotalAchatUseCase.execute(
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
            descriptionUniverselle: [],
            achat: [100.0, 200.0],
            previsionsTotal: 0,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockCalculateTotalAchatUseCase.execute(
      indexGestionMensuel: any(named: 'indexGestionMensuel'),
      indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
      listGestionMensuel: any(named: 'listGestionMensuel'),
    )).thenReturn(300.0);

    when(() => mockSaveGestionMensuelUseCase.execute(
      any<List<GestionMensuel>>(),
      remove: any(named: 'remove'),
    )).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await updateMontantAchatUseCase.execute(
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
