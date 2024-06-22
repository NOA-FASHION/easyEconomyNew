
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_description_gestion_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late SaveDescriptionGestionUseCase saveDescriptionGestionUseCase;

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
    mockSharedPreferences = MockSharedPreferences();
    saveDescriptionGestionUseCase = SaveDescriptionGestionUseCase(mockSharedPreferences);
  });

  test('Should save description and return true when data is valid', () async {
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
            descriptionUniverselle: [
              DesciprtionUniverselle(
                previsions: 10.0,
                echeance: 2,
                nombreEcheance: 3,
                id: '1',
                name: 'test',
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

    when(() => mockSharedPreferences.setStringList(any(), any())).thenAnswer((_) async => true);

    // Act
    final result = await saveDescriptionGestionUseCase.execute(
      remove: false,
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(result, true);
    verify(() => mockSharedPreferences.setStringList(any(), any())).called(1);
  });

  test('Should handle removal and clear description if length is less than 1', () async {
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

    when(() => mockSharedPreferences.setStringList(any(), any())).thenAnswer((_) async => true);

    // Act
    final result = await saveDescriptionGestionUseCase.execute(
      remove: true,
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(result, true);
    expect(listGestionMensuel[0].montantUniverselle[0].descriptionUniverselle.isEmpty, true);
    verify(() => mockSharedPreferences.setStringList(any(), any())).called(1);
  });

  test('Should handle exception from SharedPreferences', () async {
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

    when(() => mockSharedPreferences.setStringList(any(), any())).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await saveDescriptionGestionUseCase.execute(
        remove: false,
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
