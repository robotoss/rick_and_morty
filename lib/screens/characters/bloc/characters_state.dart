part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersInitialState extends CharactersState {}

class CharactersDataState extends CharactersState {
  final List<Character> characters;

  CharactersDataState({required this.characters});

  @override
  List<Object> get props => [characters];
}
