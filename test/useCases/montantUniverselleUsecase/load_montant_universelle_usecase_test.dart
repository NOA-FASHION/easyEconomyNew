import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/mappers/mapper_listGestion_mensuel_json_to_model_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/load_montant_universelle_usecase.dart';
import 'package:collection/collection.dart';

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
  late LoadMontantUniverselleUseCase loadMontantUniverselleUseCase;

  setUp(() {
    concreteMapper = ConcreteMapperListGestionMensuelJsonToModelUseCase();
    loadMontantUniverselleUseCase = LoadMontantUniverselleUseCase(concreteMapper);
  });

  bool compareMontantUniverselle(MontantUniverselle a, MontantUniverselle b) {
    return a.id == b.id &&
        a.nom == b.nom &&
        a.montant == b.montant &&
        a.unity == b.unity &&
        const ListEquality().equals(a.descriptionUniverselle, b.descriptionUniverselle) &&
        const ListEquality().equals(a.achat, b.achat) &&
        a.previsionsTotal == b.previsionsTotal &&
        a.icones == b.icones;
  }

  test('Should map json list to MontantUniverselle list', () async {
    // Arrange
    final jsonList = [
      {
        'id': '1',
        'nom': 'nom1',
        'montant': 100.0,
        'unity': 'unity1',
        'descriptionUniverselle': [],
        'achat': [],
        'previsionsTotal':0.0,
        'icones': 1,
      },
      {
        'id': '2',
        'nom': 'nom2',
        'montant': 200.0,
        'unity': 'unity2',
        'descriptionUniverselle': [],
        'achat': [],
        'previsionsTotal': 0.0,
        'icones': 2,
      },
    ];

    final montantUniverselleList = [
      MontantUniverselle(
        id: '1',
        nom: 'nom1',
        montant: 100.0,
        unity: unity_Montant_universelle.ChargeFixe,
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal: 0.0,
        icones: 1,
      ),
      MontantUniverselle(
        id: '2',
        nom: 'nom2',
        montant: 200.0,
        unity: unity_Montant_universelle.ChargeFixe,
        descriptionUniverselle: [],
        achat: [],
        previsionsTotal:0.0,
        icones: 2,
      ),
    ];

    // Act
    final result = await loadMontantUniverselleUseCase.execute(jsonList);

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
    final result = await loadMontantUniverselleUseCase.execute(jsonList);

    // Assert
    expect(result, <MontantUniverselle>[]);
  });

  test('Should handle exception from mapper', () async {
    // Arrange
    final jsonList = [
      {
        'id': '1',
        'nom': 'nom1',
        'montant': 100.0,
        'unity': 'unity1',
        'descriptionUniverselle': [],
        'achat': [],
        'previsionsTotal': 0.0,
        'icones': 1,
      },
    ];

    final faultyMapper = FaultyMapperListGestionMensuelJsonToModelUseCase();
    loadMontantUniverselleUseCase = LoadMontantUniverselleUseCase(faultyMapper);

    // Act & Assert
    expect(
      () async => await loadMontantUniverselleUseCase.execute(jsonList),
      throwsA(isA<Exception>()),
    );
  });
}
