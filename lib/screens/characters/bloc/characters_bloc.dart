import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/api/models/all_characters_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final Repository repository;
  CharactersBloc({required this.repository}) : super(CharactersInitialState());

  int _page = 1;

  List<Character> _characters = [];

  int _charactersCount = 0;

  @override
  Stream<CharactersState> mapEventToState(
    CharactersEvent event,
  ) async* {
    if (event is GetAllCharactersEvent) {
      yield* _buildGetAllCharactersEvent();
    }
  }

  Stream<CharactersState> _buildGetAllCharactersEvent() async* {
    try {
      final response = await repository.serverApi.getAllCharacters();
      _page++;
      _characters = response.results;
      _charactersCount = response.info.count;
      yield CharactersDataState(
        characters: _characters,
        charactersCount: _charactersCount,
      );
    } catch (error) {}
  }
}
