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
  final bool isLoading;

  CharactersDataState({
    required this.characters,
    required this.charactersCount,
    required this.isLoading,
  });

  @override
  List<Object> get props => [
        characters,
        charactersCount,
        isLoading,
      ];
}

class CharactersFailureState extends CharactersState {
  final String message;

  const CharactersFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
