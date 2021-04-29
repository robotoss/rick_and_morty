import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CharactersViewModel extends ChangeNotifier {
  final characterTextController = TextEditingController();
  final characterFocusNode = FocusNode();

  // List type - Column or Grid
  final _isColumnType = BehaviorSubject.seeded(true);
  Stream<bool> get getIsColumnType => _isColumnType.stream;

  void changeListViewType() {
    _isColumnType.add(!_isColumnType.value!);
  }
}
