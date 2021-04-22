import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rick_and_morty/data/helpers/theme_types.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final brightness = SchedulerBinding.instance!.window.platformBrightness;
    if (brightness == Brightness.dark) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }

    late ThemeType activeThemeType;

    SharedPreferences.getInstance().then(
      (prefs) {
        final localThemeType = prefs.getString('ThemeType');

        if (localThemeType != null) {
          activeThemeType = ThemeType.values
              .firstWhere((element) => element.toString() == localThemeType);
        } else {
          activeThemeType = ThemeType.byDevice;
        }

        if (activeThemeType == ThemeType.dark) {
          _themeData = darkTheme;
        } else if (activeThemeType == ThemeType.light) {
          _themeData = lightTheme;
        } else {
          final brightness =
              SchedulerBinding.instance!.window.platformBrightness;
          if (brightness == Brightness.dark) {
            _themeData = darkTheme;
          } else {
            _themeData = lightTheme;
          }
        }

        notifyListeners();
      },
    );

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
