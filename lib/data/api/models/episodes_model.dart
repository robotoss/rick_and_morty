// To parse this JSON data, do
//
//     final Episode = EpisodesModelFromJson(jsonString);

import 'dart:convert';

import 'list_episodes_model.dart';

List<Episode> episodesModelFromJson(String str) =>
    List<Episode>.from(json.decode(str).map((x) => Episode.fromJson(x)));

String episodesModelToJson(List<Episode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
