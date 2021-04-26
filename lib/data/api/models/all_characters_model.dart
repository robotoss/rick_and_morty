// To parse this JSON data, do
//
//     final allCharactersModel = allCharactersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllCharactersModel allCharactersModelFromJson(String str) =>
    AllCharactersModel.fromJson(json.decode(str));

String allCharactersModelToJson(AllCharactersModel data) =>
    json.encode(data.toJson());

class AllCharactersModel {
  AllCharactersModel({
    required this.info,
    required this.results,
  });

  Info info;
  List<Character> results;

  factory AllCharactersModel.fromJson(Map<String, dynamic> json) =>
      AllCharactersModel(
        info: Info.fromJson(json['info']),
        results: List<Character>.from(
            json['results'].map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'info': info.toJson(),
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  int count;
  int pages;
  String? next;
  String? prev;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json['count'],
        pages: json['pages'],
        next: json['next'],
        prev: json['prev'],
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pages': pages,
        'next': next,
        'prev': prev,
      };
}

class Character {
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  Location origin;
  Location location;
  String image;
  List<String> episode;
  String url;
  DateTime created;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: Location.fromJson(json['origin']),
        location: Location.fromJson(json['location']),
        image: json['image'],
        episode: List<String>.from(json['episode'].map((x) => x)),
        url: json['url'],
        created: DateTime.parse(json['created']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin.toJson(),
        'location': location.toJson(),
        'image': image,
        'episode': List<dynamic>.from(episode.map((x) => x)),
        'url': url,
        'created': created.toIso8601String(),
      };
}

class Location {
  Location({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}
