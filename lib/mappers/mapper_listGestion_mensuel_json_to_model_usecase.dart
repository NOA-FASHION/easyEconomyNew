import 'package:injectable/injectable.dart';

@singleton
class MapperListGestionMensuelJsonToModelUseCase {
  List<T> execute<T>(List<Map<String, dynamic>> jsonList, T Function(Map<String, dynamic>) fromJson) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}
