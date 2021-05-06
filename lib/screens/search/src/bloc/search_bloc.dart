import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Repository repository;

  SearchBloc({required this.repository}) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchResultEvent) {
      yield* _buildGetSearchResultEvent();
    }
  }

  Stream<SearchState> _buildGetSearchResultEvent() async* {}
}
