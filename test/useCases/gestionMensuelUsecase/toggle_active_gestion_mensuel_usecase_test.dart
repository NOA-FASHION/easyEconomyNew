import 'package:easyeconomy/useCases/gestionMensuelUsecase/gestionMensuelUsecase/toggle_active_gestion_mensuel_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_gestion_mensuel_usecase.dart';

class MockSaveGestionMensuelUseCase extends Mock implements SaveGestionMensuelUseCase {}

void main() {
  late MockSaveGestionMensuelUseCase mockSaveGestionMensuelUseCase;
  late ToggleActiveGestionMensuelUseCase toggleActiveGestionMensuelUseCase;

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
    mockSaveGestionMensuelUseCase = MockSaveGestionMensuelUseCase();
    toggleActiveGestionMensuelUseCase = ToggleActiveGestionMensuelUseCase(mockSaveGestionMensuelUseCase);
  });

  test('Should toggle previsionsTotal to 1 if it is 0 and save the list', () async {
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

    when(() => mockSaveGestionMensuelUseCase.execute(any())).thenAnswer((_) async => true);

    // Act
    await toggleActiveGestionMensuelUseCase.execute(
      indexGestionMensuel: 0,
      indexGestion: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle[0].previsionsTotal, 1);
    verify(() => mockSaveGestionMensuelUseCase.execute(any())).called(1);
  });

  test('Should toggle previsionsTotal to 0 if it is 1 and save the list', () async {
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
            previsionsTotal: 1,
            icones: 1,
          ),
        ],
        montantUniverselleLive: [],
      ),
    ];

    when(() => mockSaveGestionMensuelUseCase.execute(any())).thenAnswer((_) async => true);

    // Act
    await toggleActiveGestionMensuelUseCase.execute(
      indexGestionMensuel: 0,
      indexGestion: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle[0].previsionsTotal, 0);
    verify(() => mockSaveGestionMensuelUseCase.execute(any())).called(1);
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

    when(() => mockSaveGestionMensuelUseCase.execute(any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await toggleActiveGestionMensuelUseCase.execute(
        indexGestionMensuel: 0,
        indexGestion: 0,
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
