import 'dart:convert';

EpisodesListModel episodesListModelFromJson(String str) =>
    EpisodesListModel.fromJson(json.decode(str));

String episodesListModelToJson(EpisodesListModel data) =>
    json.encode(data.toJson());

class EpisodesListModel {
  EpisodesListModel({
    required this.info,
    required this.results,
  });

  Info info;
  List<Episodes> results;

  factory EpisodesListModel.fromJson(Map<String, dynamic> json) =>
      EpisodesListModel(
        info: Info.fromJson(json['info']),
        results: List<Episodes>.from(
            json['results'].map((x) => Episodes.fromJson(x))),
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
        next: json['next'] == null ? null : json['next']!,
        prev: json['prev'] == null ? null : json['prev']!,
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pages': pages,
        'next': next,
        'prev': prev,
      };
}

class Episodes {
  Episodes({
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

  factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
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
