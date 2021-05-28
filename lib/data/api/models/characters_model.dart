// To parse this JSON data, do
//
//     final Episode = EpisodesModelFromJson(jsonString);

import 'dart:convert';

import 'list_characters_model.dart';

List<Character> charactersModelFromJson(String str) =>
    List<Character>.from(json.decode(str).map((x) => Character.fromJson(x)));
