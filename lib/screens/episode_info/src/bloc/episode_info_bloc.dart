import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';
import 'package:path/path.dart' as path;

part 'episode_info_event.dart';
part 'episode_info_state.dart';

class EpisodeInfoBloc extends Bloc<EpisodeInfoEvent, EpisodeInfoState> {
  final Episode episode;
  final Repository repository;
  EpisodeInfoBloc({
    required this.episode,
    required this.repository,
  }) : super(EpisodeInfoInitialState());

  final _characters = <Character>[];

  @override
  Stream<EpisodeInfoState> mapEventToState(
    EpisodeInfoEvent event,
  ) async* {
    if (event is GetCharactersEvent) {
      yield* _buildGetCharactersEvent();
    }
  }

  Stream<EpisodeInfoState> _buildGetCharactersEvent() async* {
    // Number of episodes parced from episodes url in character data
    final episodesNumbers = <String>[];
    // Parce character data
    for (final character in episode.characters) {
      episodesNumbers.add(path.basename(character));
    }

    try {
      // Try to get data from server
      _characters.addAll(
        await repository.serverApi.getMultipleCharacters(episodesNumbers),
      );
    } catch (error) {
      yield EpisodeInfoFailureState(message: error.toString());
    }
    yield EpisodeInfoEpisodesState(characters: _characters);
  }
}
