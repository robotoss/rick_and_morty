import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainViewModel extends ChangeNotifier {
  // Navigators key for save Navigation State when change index screen
  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Active index Screen
  final _indexScreen = BehaviorSubject.seeded(0);
  Stream<int> get getIndexScreen => _indexScreen.stream;

  void changeIndexScreen(int index) {
    _indexScreen.add(index);
  }
}
