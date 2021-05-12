import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

part 'episode_info_event.dart';
part 'episode_info_state.dart';

class EpisodeInfoBloc extends Bloc<EpisodeInfoEvent, EpisodeInfoState> {
  final Repository repository;
  EpisodeInfoBloc({required this.repository}) : super(EpisodeInfoInitial());

  @override
  Stream<EpisodeInfoState> mapEventToState(
    EpisodeInfoEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
