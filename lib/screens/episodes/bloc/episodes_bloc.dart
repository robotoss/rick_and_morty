import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final Repository repository;
  EpisodesBloc({required this.repository}) : super(EpisodesInitialState());

  var _pageIndex = 1;

  var _episodes = <Episodes>[];

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
      _episodes = response.results;
    } catch (error) {
      yield EpisodesFailureState(message: error.toString());
    }
    yield EpisodesDataState(
      episodes: _episodes,
      isLoading: false,
    );
  }
}
