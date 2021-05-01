import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc/characters_bloc.dart';

class CharactersViewModel extends ChangeNotifier {
  final characterTextController = TextEditingController();
  final characterFocusNode = FocusNode();

  final scrollController = ScrollController();

  ScrollController addScrollListener(CharactersBloc bloc) {
    // Check that scrollController has't have the listener
    if (!scrollController.hasListeners) {
      // Add Listener to controller to check that usern in end of the character
      // list, and try to load more characters
      scrollController.addListener(() {
        var triggerFetchMoreSize =
            0.9 * scrollController.position.maxScrollExtent;
        if (scrollController.position.pixels > triggerFetchMoreSize) {
          if (bloc.state is CharactersDataState) {
            final _state = bloc.state as CharactersDataState;
            if (!_state.isLoading) bloc.add(GetMoreCharactersEvent());
          }
        }
      });
    }
    // Return controller to List
    return scrollController;
  }

  // List type - Column or Grid
  final _isColumnType = BehaviorSubject.seeded(true);
  Stream<bool> get getIsColumnType => _isColumnType.stream;

  void changeListViewType() {
    _isColumnType.add(!_isColumnType.value!);
  }
}
