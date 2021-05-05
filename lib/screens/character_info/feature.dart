import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/api/models/all_characters_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

import 'src/bloc/character_info_bloc.dart';
import 'src/character_info_screen.dart';

MaterialPageRoute characterInfoRoute(Character character) {
  return MaterialPageRoute(
    builder: (context) {
      return BlocProvider(
        create: (context) => CharacterInfoBloc(
          character: character,
          repository: context.read<Repository>(),
        )..add(GetEpisodesEvent()),
        child: CharacterInfoScreen(character: character),
      );
    },
  );
}
