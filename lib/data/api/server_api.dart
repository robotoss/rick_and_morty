import 'dart:convert';

import 'package:dio/dio.dart';

import 'models/all_characters_model.dart';
import 'models/list_episodes_model.dart';

class ServerApi {
  final Dio dio;
  ServerApi(this.dio);

  ///
  /// CHARACTERS
  ///

  /// Get list of all characters
  Future<AllCharactersModel> getAllCharacters(int pageIndex) async {
    final response = await dio.get<String>('character/?page=$pageIndex');
    return allCharactersModelFromJson(response.toString());
  }

  ///
  /// EPISODES
  ///

  /// Get multiple episodes
  Future<List<ListEpisodesModel>> getMultipleEpisodes(
      List<String> episodes) async {
    final response = await dio.get<String>('episode/${episodes.join(",")}');
    if (episodes.length > 1) {
      return listEpisodesModelFromJson(response.toString());
    } else {
      return [ListEpisodesModel.fromJson(jsonDecode(response.toString()))];
    }
  }
}
