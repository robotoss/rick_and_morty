import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainViewModel extends ChangeNotifier {
  // Глобальные ключи старниц
  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Стрим индекса экрана
  final _indexScreen = BehaviorSubject.seeded(0);

  Stream<int> get getIndexScreen => _indexScreen.stream;

  void changeIndexScreen(int index) {
    _indexScreen.add(index);
  }
}
