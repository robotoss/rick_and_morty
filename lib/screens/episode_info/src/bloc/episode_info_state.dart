part of 'episode_info_bloc.dart';

abstract class EpisodeInfoState extends Equatable {
  const EpisodeInfoState();
  
  @override
  List<Object> get props => [];
}

class EpisodeInfoInitial extends EpisodeInfoState {}
