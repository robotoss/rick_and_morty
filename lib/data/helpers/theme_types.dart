import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ThemeType { dark, light, byDevice }

String themeName(ThemeType themeType, AppLocalizations localizations) {
  switch (themeType) {
    case ThemeType.dark:
      return localizations.dark_theme;
    case ThemeType.light:
      return localizations.light_theme;
    case ThemeType.byDevice:
      return localizations.follow_the_system_settings;
  }
}
