part of 'episodes_bloc.dart';

abstract class EpisodesState extends Equatable {
  const EpisodesState();

  @override
  List<Object> get props => [];
}

class EpisodesInitialState extends EpisodesState {}

class EpisodesDataState extends EpisodesState {}

class EpisodesFailureState extends EpisodesState {
  final String message;

  const EpisodesFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
