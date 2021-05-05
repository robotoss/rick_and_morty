part of 'character_info_bloc.dart';

abstract class CharacterInfoState extends Equatable {
  const CharacterInfoState();

  @override
  List<Object> get props => [];
}

class CharacterInfoInitialState extends CharacterInfoState {}

class CharacterInfoEpisodesState extends CharacterInfoState {}

class CharacterInfoFailureState extends CharacterInfoState {
  final String message;

  const CharacterInfoFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
