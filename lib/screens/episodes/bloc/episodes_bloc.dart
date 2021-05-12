import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';
import 'package:rick_and_morty/screens/episodes/model.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final Repository repository;
  EpisodesBloc({required this.repository}) : super(EpisodesInitialState());

  var _pageIndex = 1;

  final _allEpisodes = <Episodes>[];

  @override
  Stream<EpisodesState> mapEventToState(
    EpisodesEvent event,
  ) async* {
    if (event is GetEpisodesEvent) {
      yield* getEpisodesEventBuild();
    }
  }

  Stream<EpisodesState> getEpisodesEventBuild() async* {
    try {
      final response = await repository.serverApi.getAllEpisodes(_pageIndex);
      _pageIndex++;
      _allEpisodes.addAll(response.results);
      if (response.info.next != null) {
        add(GetEpisodesEvent());
        return;
      }
    } catch (error) {
      yield EpisodesFailureState(message: error.toString());
    }

    final episodesBySeasonsModel = <EpisodesBySeasonsModel>[];
    for (final episode in _allEpisodes) {
      final season = int.parse(episode.episode.substring(1, 3));
      if (episodesBySeasonsModel.isEmpty) {
        episodesBySeasonsModel.add(
          EpisodesBySeasonsModel(
            season: 1,
            episodes: [episode],
          ),
        );
      } else if (episodesBySeasonsModel.last.season == season) {
        episodesBySeasonsModel.last.episodes.add(episode);
      } else {
        episodesBySeasonsModel.add(
          EpisodesBySeasonsModel(
            season: season,
            episodes: [episode],
          ),
        );
      }
    }

    yield EpisodesDataState(
      episodes: episodesBySeasonsModel,
      isLoading: false,
    );
  }
}
