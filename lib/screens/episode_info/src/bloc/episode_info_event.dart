part of 'episode_info_bloc.dart';

abstract class EpisodeInfoEvent extends Equatable {
  const EpisodeInfoEvent();

  @override
  List<Object> get props => [];
}

class GetCharactersEvent extends EpisodeInfoEvent {}
