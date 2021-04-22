import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    // primarySwatch: Colors.grey,
    primaryColor: AppColors.primaryDark,
    brightness: Brightness.dark,
    // backgroundColor: const Color(0xFF212121),
    // accentColor: Colors.white,
    // accentIconTheme: IconThemeData(color: Colors.black),
    canvasColor: AppColors.lightBlack,
    dividerColor: Colors.black12,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.green,
      unselectedItemColor: AppColors.gray,
    ),
  );

  final lightTheme = ThemeData(
    // primarySwatch: Colors.grey,
    primaryColor: AppColors.primaryLight,
    brightness: Brightness.light,
    // backgroundColor: const Color(0xFFE5E5E5),
    // accentColor: Colors.black,
    // accentIconTheme: IconThemeData(color: Colors.white),
    canvasColor: Colors.white,
    dividerColor: Colors.white54,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.primaryLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.gray4,
    ),
  );

  late ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    _themeData = lightTheme;
    // StorageManager.readData('themeMode').then((value) {
    //   print('value read from storage: ' + value.toString());
    //   var themeMode = value ?? 'light';
    //   if (themeMode == 'light') {
    //     _themeData = lightTheme;
    //   } else {
    //     print('setting dark theme');
    //     _themeData = darkTheme;
    //   }
    //   notifyListeners();
    // });
  }

  // void setDarkMode() async {
  //   _themeData = darkTheme;
  //   StorageManager.saveData('themeMode', 'dark');
  //   notifyListeners();
  // }

  // void setLightMode() async {
  //   _themeData = lightTheme;
  //   StorageManager.saveData('themeMode', 'light');
  //   notifyListeners();
  // }
}
