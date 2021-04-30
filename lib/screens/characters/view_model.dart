import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CharactersViewModel extends ChangeNotifier {
  final characterTextController = TextEditingController();
  final characterFocusNode = FocusNode();

  final scrollController = ScrollController();

  ScrollController addScrollListener(VoidCallback onEndScroll) {
    if (!scrollController.hasListeners) {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent >
                scrollController.offset &&
            scrollController.position.maxScrollExtent -
                    scrollController.offset <=
                50) {
          onEndScroll();
        }
      });
    }
    return scrollController;
  }

  // List type - Column or Grid
  final _isColumnType = BehaviorSubject.seeded(true);
  Stream<bool> get getIsColumnType => _isColumnType.stream;

  void changeListViewType() {
    _isColumnType.add(!_isColumnType.value!);
  }
}
