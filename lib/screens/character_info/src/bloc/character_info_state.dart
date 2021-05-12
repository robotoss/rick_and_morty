part of 'character_info_bloc.dart';

abstract class CharacterInfoState extends Equatable {
  const CharacterInfoState();

  @override
  List<Object> get props => [];
}

class CharacterInfoInitialState extends CharacterInfoState {}

class CharacterInfoEpisodesState extends CharacterInfoState {
  final List<Episode> episodes;
  CharacterInfoEpisodesState({required this.episodes});

  @override
  List<Object> get props => [episodes];
}

class CharacterInfoFailureState extends CharacterInfoState {
  final String message;

  const CharacterInfoFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
