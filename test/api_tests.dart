// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/data/api/dio_settings.dart';
import 'package:rick_and_morty/data/api/server_api.dart';

void main() {
  final dio = DioSettings().dio;
  final serverApi = ServerApi(dio);

  group('CHARACTERS', () {
    test('getAllCharacters', () async {
      final response = await serverApi.getAllCharacters();

      expect(response.results, isNotEmpty);
    });
  });
}
