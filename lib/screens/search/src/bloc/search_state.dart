part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchActiveState extends SearchState {
  final List<Character> characters;

  const SearchActiveState({required this.characters});

  @override
  List<Object> get props => [characters];
}

class SearchLoadingState extends SearchState {}

class SearchFailureState extends SearchState {
  final String message;

  const SearchFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
