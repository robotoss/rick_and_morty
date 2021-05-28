import 'dart:convert';

import 'package:dio/dio.dart';

import 'models/characters_model.dart';
import 'models/list_characters_model.dart';
import 'models/episodes_model.dart';
import 'models/list_episodes_model.dart';

class ServerApi {
  final Dio dio;
  ServerApi(this.dio);

  ///
  /// CHARACTERS
  ///

  /// Get multiple characters
  Future<List<Character>> getMultipleCharacters(List<String> characters) async {
    final response = await dio.get<String>('character/${characters.join(",")}');
    if (characters.length > 1) {
      return charactersModelFromJson(response.toString());
    } else {
      return [Character.fromJson(jsonDecode(response.toString()))];
    }
  }

  /// Get list of all characters
  Future<ListCharactersModel> getAllCharacters(int pageIndex) async {
    final response = await dio.get<String>('character/?page=$pageIndex');
    return ListCharactersModelFromJson(response.toString());
  }

  /// Get list of all characters
  Future<ListCharactersModel> getCharactersByName(
      int pageIndex, String name) async {
    final response =
        await dio.get<String>('character/?page=$pageIndex&name=$name');
    return ListCharactersModelFromJson(response.toString());
  }

  ///
  /// EPISODES
  ///

  /// Get multiple episodes
  Future<List<Episode>> getMultipleEpisodes(List<String> episodes) async {
    final response = await dio.get<String>('episode/${episodes.join(",")}');
    if (episodes.length > 1) {
      return episodesModelFromJson(response.toString());
    } else {
      return [Episode.fromJson(jsonDecode(response.toString()))];
    }
  }

  /// Get list of all episodes
  Future<EpisodesListModel> getAllEpisodes(int pageIndex) async {
    final response = await dio.get<String>('episode/?page=$pageIndex');
    return episodesListModelFromJson(response.toString());
  }
}
