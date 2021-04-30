import 'package:dio/dio.dart';

import 'models/all_characters_model.dart';

class ServerApi {
  final Dio dio;
  ServerApi(this.dio);

  ///
  /// CHARACTERS
  ///

  /// Get list of all characters
  Future<AllCharactersModel> getAllCharacters(int pageIndex) async {
    final response = await dio.get('character/?page=$pageIndex');
    return allCharactersModelFromJson(response.toString());
  }
}
