import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/api/models/all_characters_model.dart';

import 'src/character_info_screen.dart';

MaterialPageRoute characterInfoRoute(Character character) {
  return MaterialPageRoute(
    builder: (context) {
      return CharacterInfoScreen(character: character);
    },
  );
}
