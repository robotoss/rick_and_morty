import 'package:dio/dio.dart';

import 'models/all_characters_model.dart';

class ServerApi {
  final Dio dio;
  ServerApi(this.dio);

  ///
  /// CHARACTERS
  ///

  /// Get list of all characters
  Future<AllCharactersModel> getAllCharacters() async {
    final response = await dio.get('character');
    return allCharactersModelFromJson(response.toString());
  }
}
