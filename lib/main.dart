import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/main/main_fragment.dart';
import 'theme/theme_manager.dart';

void main() {
  return runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        title: 'Rick & Morty',
        home: MainFragment(),
      ),
    );
  }
}
