import 'package:rick_and_morty/data/helpers/theme_types.dart';
import 'package:rick_and_morty/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  late SharedPreferences prefs;

  ThemeType? getThemeType() {
    final type = prefs.getString(Constants.ThemeType);
    return type as ThemeType;
  }
}
