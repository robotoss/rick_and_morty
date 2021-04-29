part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersInitialState extends CharactersState {}

class CharactersDataState extends CharactersState {
  final List<Character> characters;
  final int charactersCount;

  CharactersDataState({
    required this.characters,
    required this.charactersCount,
  });

  @override
  List<Object> get props => [
        characters,
        charactersCount,
      ];
}
