import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';
import 'package:path/path.dart' as path;

part 'character_info_event.dart';
part 'character_info_state.dart';

class CharacterInfoBloc extends Bloc<CharacterInfoEvent, CharacterInfoState> {
  final Character character;
  final Repository repository;
  CharacterInfoBloc({
    required this.character,
    required this.repository,
  }) : super(CharacterInfoInitialState());

  @override
  Stream<CharacterInfoState> mapEventToState(
    CharacterInfoEvent event,
  ) async* {
    if (event is GetEpisodesEvent) {
      yield* _buildGetEpisodesEvent();
    }
  }

  Stream<CharacterInfoState> _buildGetEpisodesEvent() async* {
    List<ListEpisodesModel>? episodes;
    var episodesNumbers = <String>[];

    for (final episode in character.episode) {
      episodesNumbers.add(path.basename(episode));
    }

    try {
      episodes =
          await repository.serverApi.getMultipleEpisodes(episodesNumbers);
    } catch (error) {
      yield CharacterInfoFailureState(message: error.toString());
    }
    yield CharacterInfoEpisodesState(episodes: episodes ?? []);
  }
}
