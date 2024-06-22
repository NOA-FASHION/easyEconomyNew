import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/calculate_total_achat_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGestionMensuel extends Mock implements GestionMensuel {}
class MockMontantUniverselle extends Mock implements MontantUniverselle {}

void main() {
  late CalculateTotalAchatUseCase calculateTotalAchatUseCase;

  setUp(() {
    calculateTotalAchatUseCase = CalculateTotalAchatUseCase();
  });

  test('Should return the total of achats for a given montantUniverselle', () {
    // Arrange
    final achatList = [10.0, 20.0, 30.0];
    final montantUniverselle = MontantUniverselle(
      unity:  unity_Montant_universelle.ChargeFixe,
      id: '123',
      montant: 100.0,
      nom: 'Test',
      descriptionUniverselle: [],
      achat: achatList,
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
    final total = calculateTotalAchatUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(total, 60.0);
  });

  test('Should return 0 if achat list is empty', () {
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
    final total = calculateTotalAchatUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(total, 0.0);
  });

  test('Should handle multiple GestionMensuel and MontantUniverselle correctly', () {
    // Arrange
    final achatList1 = [5.0, 15.0];
    final achatList2 = [10.0, 20.0, 30.0];
    final montantUniverselle1 = MontantUniverselle(
      unity:  unity_Montant_universelle.ChargeFixe,
      id: '123',
      montant: 50.0,
      nom: 'Test1',
      descriptionUniverselle: [],
      achat: achatList1,
      previsionsTotal: 0,
      icones: 1,
    );
    final montantUniverselle2 = MontantUniverselle(
      unity: unity_Montant_universelle.ChargeFixe,
      id: '456',
      montant: 100.0,
      nom: 'Test2',
      descriptionUniverselle: [],
      achat: achatList2,
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
    final total1 = calculateTotalAchatUseCase.execute(
      indexGestionMensuel: 0,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );
    final total2 = calculateTotalAchatUseCase.execute(
      indexGestionMensuel: 1,
      indexGestionMensuelMontantUniv: 0,
      listGestionMensuel: listGestionMensuel,
    );

    // Assert
    expect(total1, 20.0);
    expect(total2, 60.0);
  });
}
