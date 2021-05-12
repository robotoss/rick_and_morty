import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

import 'src/bloc/episode_info_bloc.dart';
import 'src/episode_info_screen.dart';

MaterialPageRoute episodeInfoRoute(Episode character) {
  return MaterialPageRoute(
    builder: (context) {
      return BlocProvider(
        create: (context) => EpisodeInfoBloc(
          repository: context.read<Repository>(),
        ),
        child: EpisodeInfoScreen(),
      );
    },
  );
}
