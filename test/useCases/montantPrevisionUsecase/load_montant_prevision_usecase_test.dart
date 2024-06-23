import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/load_montant_prevision_usecase.dart';
import 'package:easyeconomy/mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class ConcreteMapperListGestionMensuelJsonToModelUseCase implements MapperListGestionMensuelJsonToModelUseCase {
  @override
  List<T> execute<T>(List<Map<String, dynamic>> jsonList, T Function(Map<String, dynamic>) fromJson) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}

class FaultyMapperListGestionMensuelJsonToModelUseCase implements MapperListGestionMensuelJsonToModelUseCase {
  @override
  List<T> execute<T>(List<Map<String, dynamic>> jsonList, T Function(Map<String, dynamic>) fromJson) {
    throw Exception('Mapping failed');
  }
}

void main() {
  late ConcreteMapperListGestionMensuelJsonToModelUseCase concreteMapper;
  late LoadMontantPrevisionUseCase loadMontantPrevisionUseCase;

  setUp(() {
    concreteMapper = ConcreteMapperListGestionMensuelJsonToModelUseCase();
    loadMontantPrevisionUseCase = LoadMontantPrevisionUseCase(concreteMapper);
  });

  bool compareMontantUniverselle(MontantUniverselle a, MontantUniverselle b) {
    return a.id == b.id &&
        a.unity == b.unity &&
        a.montant == b.montant &&
        a.nom == b.nom &&
        a.previsionsTotal == b.previsionsTotal &&
        a.icones == b.icones &&
        const ListEquality().equals(a.descriptionUniverselle, b.descriptionUniverselle) &&
        const ListEquality().equals(a.achat, b.achat);
  }

  test('Should map json list to MontantUniverselle list', () async {
    // Arrange
    final jsonList = [
      {
        'id': 'id1',
        'unity': 'unity1',
        'montant': 100.0,
        'nom': 'nom1',
        'descriptionUniverselle': [],
        'achat': [],
        'previsionsTotal':0.0,
        'icones': 1,
      },
      {
        'id': 'id2',
        'unity': 'unity2',
        'montant': 200.0,
        'nom': 'nom2',
        'descriptionUniverselle': [],
        'achat': [],
        'previsionsTotal':0.0,
        'icones': 2,
      },
    ];

    final montantUniverselleList = [
      MontantUniverselle(
        id: 'id1',
        unity: unity_Montant_universelle.ChargeFixe,
        montant: 100.0,
        nom: 'nom1',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal:0.0,
        icones: 1,
      ),
      MontantUniverselle(
        id: 'id2',
       unity: unity_Montant_universelle.ChargeFixe,
        montant: 200.0,
        nom: 'nom2',
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal:0.0,
        icones: 2,
      ),
    ];

    // Act
    final result = await loadMontantPrevisionUseCase.execute(jsonList);

    // Assert
    expect(result.length, montantUniverselleList.length);
    for (int i = 0; i < result.length; i++) {
      expect(compareMontantUniverselle(result[i], montantUniverselleList[i]), false);
    }
  });

  test('Should handle empty json list', () async {
    // Arrange
    final jsonList = <Map<String, dynamic>>[];

    // Act
    final result = await loadMontantPrevisionUseCase.execute(jsonList);

    // Assert
    expect(result, <MontantUniverselle>[]);
  });

  test('Should handle exception from mapper', () async {
    // Arrange
    final jsonList = [
      {
        'id': 'id1',
        'unity': 'unity1',
        'montant': 'invalid', // This will cause an exception
        'nom': 'nom1',
        'descriptionUniverselle': [],
        'achat': [],
        'previsionsTotal':0.0,
        'icones': 1,
      },
    ];

    final faultyMapper = FaultyMapperListGestionMensuelJsonToModelUseCase();
    loadMontantPrevisionUseCase = LoadMontantPrevisionUseCase(faultyMapper);

    // Act & Assert
    expect(
      () async => await loadMontantPrevisionUseCase.execute(jsonList),
      throwsA(isA<Exception>()),
    );
  });
}
