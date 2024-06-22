import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_description_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/save_description_gestion_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockSaveDescriptionGestionUseCase extends Mock implements SaveDescriptionGestionUseCase {}

void main() {
  late MockSaveDescriptionGestionUseCase mockSaveDescriptionGestionUseCase;
  late RemoveGestionDescriptionGestionUseCase removeGestionDescriptionGestionUseCase;

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
    mockSaveDescriptionGestionUseCase = MockSaveDescriptionGestionUseCase();
    removeGestionDescriptionGestionUseCase = RemoveGestionDescriptionGestionUseCase(mockSaveDescriptionGestionUseCase);
  });

  test('Should remove description and save the list', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [
          MontantUniverselle(
            unity:unity_Montant_universelle.ChargeFixe,
            id: 'id',
            montant: 100,
            nom: 'nom',
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

    when(() => mockSaveDescriptionGestionUseCase.execute(
      remove: any(named: 'remove'),
      indexGestionMensuel: any(named: 'indexGestionMensuel'),
      indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
      listGestionMensuel: any(named: 'listGestionMensuel'),
    )).thenAnswer((_) async => Future.value(false));

    // Act
    await removeGestionDescriptionGestionUseCase.execute(
      index: 0,
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      idGestionMensMontanUniv: '1',
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(listGestionMensuel[0].montantUniverselle[0].descriptionUniverselle.isEmpty, true);
    verify(() => mockSaveDescriptionGestionUseCase.execute(
      remove: true,
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    )).called(1);
  });

  test('Should handle exception from saveDescriptionGestionUseCase', () async {
    // Arrange
    final List<GestionMensuel> listGestionMensuel = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [
          MontantUniverselle(
            unity:unity_Montant_universelle.ChargeFixe,
            id: 'id',
            montant: 100,
            nom: 'nom',
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

    when(() => mockSaveDescriptionGestionUseCase.execute(
      remove: any(named: 'remove'),
      indexGestionMensuel: any(named: 'indexGestionMensuel'),
      indexGestionMensuelMontantUniv: any(named: 'indexGestionMensuelMontantUniv'),
      listGestionMensuel: any(named: 'listGestionMensuel'),
    )).thenThrow(Exception('Save failed'));

    // Act & Assert
    expect(
      () async => await removeGestionDescriptionGestionUseCase.execute(
        index: 0,
        indexGestionMensuel: 0,
        indexGestionMensuelMontantUniv: 0,
        idGestionMensMontanUniv: '1',
        listGestionMensuel: listGestionMensuel,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
