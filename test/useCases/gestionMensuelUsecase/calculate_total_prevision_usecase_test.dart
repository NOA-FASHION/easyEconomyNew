import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_prevision_usecase.dart';

void main() {
  late CalculateTotalPrevisionUseCase calculateTotalPrevisionUseCase;

  setUp(() {
    calculateTotalPrevisionUseCase = CalculateTotalPrevisionUseCase();
  });

  test('Should return the total of previsions for a given montantUniverselle', () {
    // Arrange
    final descriptionUniverselleList = [
      DesciprtionUniverselle(
        previsions: 10.0,
        echeance: 2,
        nombreEcheance: 3,
        id: '1',
        name: 'test1',
        adresseImage: '',
        description: unity_description.tache,
        commentaire: '',
      ),
      DesciprtionUniverselle(
        previsions: 20.0,
        echeance: 2,
        nombreEcheance: 3,
        id: '2',
        name: 'test2',
        adresseImage: '',
        description: unity_description.tache,
        commentaire: '',
      ),
      DesciprtionUniverselle(
        previsions: 30.0,
        echeance: 2,
        nombreEcheance: 3,
        id: '3',
        name: 'test3',
        adresseImage: '',
        description: unity_description.tache,
        commentaire: '',
      ),
    ];
    final montantUniverselle = MontantUniverselle(
      unity: unity_Montant_universelle.ChargeFixe,
      id: '123',
      montant: 100.0,
      nom: 'Test',
      descriptionUniverselle: descriptionUniverselleList,
      achat: [],
      previsionsTotal: 0,
      icones: 1,
    );
    final gestionMensuel = GestionMensuel(
      idGestion: '1',
      nom: 'Gestion1',
      mois: 'Jan',
      tendance: 'stable',
      montantUniverselle: [montantUniverselle],
      montantUniverselleLive: [],
    );

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];

    // Act
    final total = calculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(total, 60.0);
  });

  test('Should return 0 if descriptionUniverselle list is empty', () {
    // Arrange
    final montantUniverselle = MontantUniverselle(
      unity: unity_Montant_universelle.ChargeFixe,
      id: '123',
      montant: 100.0,
      nom: 'Test',
      descriptionUniverselle: [],
      achat: [],
      previsionsTotal: 0,
      icones: 1,
    );
    final gestionMensuel = GestionMensuel(
      idGestion: '1',
      nom: 'Gestion1',
      mois: 'Jan',
      tendance: 'stable',
      montantUniverselle: [montantUniverselle],
      montantUniverselleLive: [],
    );

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel];

    // Act
    final total = calculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(total, 0.0);
  });

  test('Should handle multiple GestionMensuel and MontantUniverselle correctly', () {
    // Arrange
    final descriptionUniverselleList1 = [
      DesciprtionUniverselle(
        previsions: 5.0,
        echeance: 2,
        nombreEcheance: 3,
        id: '1',
        name: 'test1',
        adresseImage: '',
        description: unity_description.tache,
        commentaire: '',
      ),
      DesciprtionUniverselle(
        previsions: 15.0,
        echeance: 2,
        nombreEcheance: 3,
        id: '2',
        name: 'test2',
        adresseImage: '',
        description: unity_description.tache,
        commentaire: '',
      ),
    ];
    final descriptionUniverselleList2 = [
      DesciprtionUniverselle(
        previsions: 10.0,
        echeance: 2,
        nombreEcheance: 3,
        id: '3',
        name: 'test3',
        adresseImage: '',
        description: unity_description.tache,
        commentaire: '',
      ),
      DesciprtionUniverselle(
        previsions: 20.0,
        echeance: 2,
        nombreEcheance: 3,
        id: '4',
        name: 'test4',
        adresseImage: '',
        description: unity_description.tache,
        commentaire: '',
      ),
      DesciprtionUniverselle(
        previsions: 30.0,
        echeance: 2,
        nombreEcheance: 3,
        id: '5',
        name: 'test5',
        adresseImage: '',
        description: unity_description.tache,
        commentaire: '',
      ),
    ];
    final montantUniverselle1 = MontantUniverselle(
      unity: unity_Montant_universelle.ChargeFixe,
      id: '123',
      montant: 50.0,
      nom: 'Test1',
      descriptionUniverselle: descriptionUniverselleList1,
      achat: [],
      previsionsTotal: 0,
      icones: 1,
    );
    final montantUniverselle2 = MontantUniverselle(
      unity: unity_Montant_universelle.ChargeFixe,
      id: '456',
      montant: 100.0,
      nom: 'Test2',
      descriptionUniverselle: descriptionUniverselleList2,
      achat: [],
      previsionsTotal: 0,
      icones: 2,
    );
    final gestionMensuel1 = GestionMensuel(
      idGestion: '1',
      nom: 'Gestion1',
      mois: 'Jan',
      tendance: 'stable',
      montantUniverselle: [montantUniverselle1],
      montantUniverselleLive: [],
    );
    final gestionMensuel2 = GestionMensuel(
      idGestion: '2',
      nom: 'Gestion2',
      mois: 'Feb',
      tendance: 'increasing',
      montantUniverselle: [montantUniverselle2],
      montantUniverselleLive: [],
    );

    final List<GestionMensuel> listGestionMensuel = [gestionMensuel1, gestionMensuel2];

    // Act
    final total1 = calculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );
    final total2 = calculateTotalPrevisionUseCase.execute(
      indexGestionMensuel: 1,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(total1, 20.0);
    expect(total2, 60.0);
  });
}
