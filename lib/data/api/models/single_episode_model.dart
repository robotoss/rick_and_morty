// To parse this JSON data, do
//
//     final singleEpisodesModel = singleEpisodesModelFromJson(jsonString);

import 'dart:convert';

SingleEpisodesModel singleEpisodesModelFromJson(String str) =>
    SingleEpisodesModel.fromJson(json.decode(str));

String singleEpisodesModelToJson(SingleEpisodesModel data) =>
    json.encode(data.toJson());

class SingleEpisodesModel {
  SingleEpisodesModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  int id;
  String name;
  String airDate;
  String episode;
  List<String> characters;
  String url;
  DateTime created;

  factory SingleEpisodesModel.fromJson(Map<String, dynamic> json) =>
      SingleEpisodesModel(
        id: json['id'],
        name: json['name'],
        airDate: json['air_date'],
        episode: json['episode'],
        characters: List<String>.from(json['characters'].map((x) => x)),
        url: json['url'],
        created: DateTime.parse(json['created']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'air_date': airDate,
        'episode': episode,
        'characters': List<dynamic>.from(characters.map((x) => x)),
        'url': url,
        'created': created.toIso8601String(),
      };
}
