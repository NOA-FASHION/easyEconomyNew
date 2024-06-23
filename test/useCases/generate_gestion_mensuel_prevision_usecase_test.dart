import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/generate_gestion_mensuel_prevision_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

void main() {
  late GenerateGestionMensuelPrevisionUseCase useCase;

  setUp(() {
    useCase = GenerateGestionMensuelPrevisionUseCase();
  });

  test('Should generate list of MontantUniverselle with previsionsTotal set to 0 and achat empty', () {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [
   
      MontantUniverselle(
        unity: unity_Montant_universelle.ChargeFixe,
        id: 'id2',
        montant: 200.0,
        nom: 'nom2',
        descriptionUniverselle: [
          DesciprtionUniverselle(previsions: 20.0, echeance: 3, nombreEcheance: 4, id: '2', name: 'test2', adresseImage: '', description: unity_description.achat, commentaire: '')
        ],
        achat: [150.0],
        previsionsTotal: 10.0,
        icones: 2,
      ),
    ];

    // Act
    final result = useCase.execute(listMontantUniverselle);

    // Assert
  

    expect(result[0].unity, unity_Montant_universelle.ChargeFixe,);
    expect(result[0].id, 'id2');
    expect(result[0].montant, 200.0);
    expect(result[0].nom, 'nom2');
    expect(result[0].descriptionUniverselle.length, 1);
    expect(result[0].achat, []);
    expect(result[0].previsionsTotal, 0);
    expect(result[0].icones, 2);
  });

  test('Should handle empty input list', () {
    // Arrange
    final List<MontantUniverselle> listMontantUniverselle = [];

    // Act
    final result = useCase.execute(listMontantUniverselle);

    // Assert
    expect(result, []);
  });
}
