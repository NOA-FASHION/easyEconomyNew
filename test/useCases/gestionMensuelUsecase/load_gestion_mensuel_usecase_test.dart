import 'package:easyeconomy/useCases/gestionMensuelUsecase/load_gestion_mensuel_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
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
  late LoadGestionMensuelUseCase loadGestionMensuelUseCase;

  setUp(() {
    concreteMapper = ConcreteMapperListGestionMensuelJsonToModelUseCase();
    loadGestionMensuelUseCase = LoadGestionMensuelUseCase(concreteMapper);
  });

  bool compareGestionMensuel(GestionMensuel a, GestionMensuel b) {
    return a.idGestion == b.idGestion &&
        a.nom == b.nom &&
        a.mois == b.mois &&
        a.tendance == b.tendance &&
        const ListEquality().equals(a.montantUniverselle, b.montantUniverselle) &&
        const ListEquality().equals(a.montantUniverselleLive, b.montantUniverselleLive);
  }

  test('Should map json list to GestionMensuel list', () async {
    // Arrange
    final jsonList = [
      {
        'idGestion': '1',
        'nom': 'Gestion1',
        'mois': 'Jan',
        'tendance': 'stable',
        'montantUniverselle': [],
        'montantUniverselleLive': [],
      },
      {
        'idGestion': '2',
        'nom': 'Gestion2',
        'mois': 'Feb',
        'tendance': 'increasing',
        'montantUniverselle': [],
        'montantUniverselleLive': [],
      },
    ];

    final gestionMensuelList = [
      GestionMensuel(
        idGestion: '1',
        nom: 'Gestion1',
        mois: 'Jan',
        tendance: 'stable',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
      GestionMensuel(
        idGestion: '2',
        nom: 'Gestion2',
        mois: 'Feb',
        tendance: 'increasing',
        montantUniverselle: [],
        montantUniverselleLive: [],
      ),
    ];

    // Act
    final result = await loadGestionMensuelUseCase.execute(jsonList);

    // Assert
    expect(result.length, gestionMensuelList.length);
    for (int i = 0; i < result.length; i++) {
      expect(compareGestionMensuel(result[i], gestionMensuelList[i]), true);
    }
  });

  test('Should handle empty json list', () async {
    // Arrange
    final jsonList = <Map<String, dynamic>>[];

    // Act
    final result = await loadGestionMensuelUseCase.execute(jsonList);

    // Assert
    expect(result, <GestionMensuel>[]);
  });

  test('Should handle exception from mapper', () async {
    // Arrange
    final jsonList = [
      {
        'idGestion': '1',
        'nom': 'Gestion1',
        'mois': 'Jan',
        'tendance': 'stable',
        'montantUniverselle': [],
        'montantUniverselleLive': [],
      },
    ];

    final faultyMapper = FaultyMapperListGestionMensuelJsonToModelUseCase();
    loadGestionMensuelUseCase = LoadGestionMensuelUseCase(faultyMapper);

    // Act & Assert
    expect(
      () async => await loadGestionMensuelUseCase.execute(jsonList),
      throwsA(isA<Exception>()),
    );
  });
}
