import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final Repository repository;
  CharactersBloc({required this.repository}) : super(CharactersInitialState());

  var _pageIndex = 1;

  var _characters = <Character>[];

  var _charactersCount = 0;

  var endList = false;

  @override
  Stream<CharactersState> mapEventToState(
    CharactersEvent event,
  ) async* {
    if (event is GetAllCharactersEvent) {
      yield* _buildGetAllCharactersEvent();
    }
    if (event is GetMoreCharactersEvent) {
      final _state = state as CharactersDataState;
      if (!_state.isLoading && !endList) {
        yield* _buildGetMoreCharactersEvent();
      }
    }
  }

  Stream<CharactersState> _buildGetAllCharactersEvent() async* {
    try {
      // Try to get data from server
      final response = await repository.serverApi.getAllCharacters(_pageIndex);
      // Up index to download next page from server
      _pageIndex++;
      // Set data from sever to local variabels
      _characters = response.results;
      _charactersCount = response.info.count;
    } catch (error) {
      yield CharactersFailureState(message: error.toString());
    }
    yield CharactersDataState(
      characters: _characters,
      charactersCount: _charactersCount,
      isLoading: false,
    );
  }

  Stream<CharactersState> _buildGetMoreCharactersEvent() async* {
    yield CharactersDataState(
      characters: _characters,
      charactersCount: _charactersCount,
      isLoading: true,
    );

    try {
      // Try to get data from server
      final response = await repository.serverApi.getAllCharacters(_pageIndex);
      if (response.info.next != null) {
        // Up index to download next page from server
        _pageIndex++;
      } else {
        endList = true;
      }
      _characters.addAll(response.results);
    } catch (error) {
      yield CharactersFailureState(message: error.toString());
    }
    yield CharactersDataState(
      characters: _characters,
      charactersCount: _charactersCount,
      isLoading: false,
    );
  }
}
