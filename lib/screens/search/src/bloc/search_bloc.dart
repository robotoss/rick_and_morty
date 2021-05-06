import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';
import 'package:rick_and_morty/screens/search/feature.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Repository repository;
  final SearchType searchType;

  SearchBloc({
    required this.repository,
    required this.searchType,
  }) : super(SearchInitialState());

  int _pageIndex = 1;

  List<Character> _characters = [];

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchResultEvent) {
      yield* _buildGetSearchResultEvent(event.searchText);
    }
  }

  Stream<SearchState> _buildGetSearchResultEvent(String searchText) async* {
    _pageIndex = 1;
    if (searchText.isEmpty) {
      _characters = [];
      yield SearchActiveState(characters: _characters);
      return;
    }
    yield SearchLoadingState();
    try {
      final result = await repository.serverApi
          .getCharactersByName(_pageIndex, searchText);
      _characters = result.results;
      _pageIndex++;
    } catch (error) {
      yield SearchFailureState(message: error.toString());
    }

    yield SearchActiveState(characters: _characters);
  }
}
