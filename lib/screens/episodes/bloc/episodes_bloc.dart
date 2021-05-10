import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final Repository repository;
  EpisodesBloc({required this.repository}) : super(EpisodesInitialState());

  @override
  Stream<EpisodesState> mapEventToState(
    EpisodesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
