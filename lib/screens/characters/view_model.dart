import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CharactersViewModel extends ChangeNotifier {
  final characterTextController = TextEditingController();
  final characterFocusNode = FocusNode();

  final scrollController = ScrollController();

  ScrollController addScrollListener(Function onEndScroll) {
    if (!scrollController.hasListeners) {
      scrollController.addListener(() {
        var canUpdate = true;
        if (scrollController.position.maxScrollExtent >
                scrollController.offset &&
            scrollController.position.maxScrollExtent -
                    scrollController.offset <=
                50 &&
            canUpdate) {
          canUpdate = true;
          onEndScroll();
        } else {
          canUpdate = true;
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
