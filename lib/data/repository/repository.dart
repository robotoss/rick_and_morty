import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/api/dio_settings.dart';
import 'package:rick_and_morty/data/api/server_api.dart';
import 'package:rick_and_morty/data/helpers/theme_types.dart';
import 'package:rick_and_morty/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Repository() {
    init();
  }

  Future init() async {
    _dio = _getDio();
    serverApi = ServerApi(_dio);
    _prefs = await SharedPreferences.getInstance();
  }

  late SharedPreferences _prefs;
  late Dio _dio;
  late ServerApi serverApi;

  Dio _getDio() {
    final apiSettings = DioSettings();
    return apiSettings.dio;
  }

  ThemeType? getThemeType() {
    final type = _prefs.getString(Constants.ThemeType);
    return type as ThemeType;
  }
}
