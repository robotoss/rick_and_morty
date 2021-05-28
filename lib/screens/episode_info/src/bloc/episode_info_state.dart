part of 'episode_info_bloc.dart';

abstract class EpisodeInfoState extends Equatable {
  const EpisodeInfoState();

  @override
  List<Object> get props => [];
}

class EpisodeInfoInitialState extends EpisodeInfoState {}

class EpisodeInfoEpisodesState extends EpisodeInfoState {
  final List<Character> characters;
  EpisodeInfoEpisodesState({required this.characters});

  @override
  List<Object> get props => [characters];
}

class EpisodeInfoFailureState extends EpisodeInfoState {
  final String message;

  const EpisodeInfoFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
