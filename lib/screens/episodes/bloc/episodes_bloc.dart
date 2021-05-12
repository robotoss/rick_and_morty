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

  final _allEpisodes = <Episode>[];

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
      // Try to get data from server
      final response = await repository.serverApi.getAllEpisodes(_pageIndex);
      // Up index to download next page from server
      _pageIndex++;
      _allEpisodes.addAll(response.results);
      if (response.info.next != null) {
        // If we have nextPage we try to get more episodes data
        add(GetEpisodesEvent());
        return;
      }
    } catch (error) {
      yield EpisodesFailureState(message: error.toString());
    }
    // Variable to sort all episodes by seasons
    final episodesBySeasonsModel = <EpisodesBySeasonsModel>[];
    for (final episode in _allEpisodes) {
      // Try to get season in int by parce season code of the episode.
      // it is like S01E01
      final season = int.parse(episode.episode.substring(1, 3));
      // Create new season data
      if (episodesBySeasonsModel.isEmpty) {
        episodesBySeasonsModel.add(
          EpisodesBySeasonsModel(
            season: 1,
            episodes: [episode],
          ),
        );
        // Add episodes to season
      } else if (episodesBySeasonsModel.last.season == season) {
        episodesBySeasonsModel.last.episodes.add(episode);
        // Create new season data
      } else {
        episodesBySeasonsModel.add(
          EpisodesBySeasonsModel(
            season: season,
            episodes: [episode],
          ),
        );
      }
    }

    yield EpisodesDataState(episodes: episodesBySeasonsModel);
  }
}
