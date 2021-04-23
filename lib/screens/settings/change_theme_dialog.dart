import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/data/helpers/theme_types.dart';
import 'package:rick_and_morty/theme/theme_manager.dart';

Future<void> showChangeThemeDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return _ChangeTheme();
    },
  );
}

class _ChangeTheme extends StatelessWidget {
  const _ChangeTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeNotifier>(context);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.the_color_theme_of_the_app,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 24),
            RadioListTile<ThemeType>(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                AppLocalizations.of(context)!.dark_theme,
              ),
              value: ThemeType.dark,
              groupValue: themeVM.getThemeType(),
              onChanged: (value) => themeVM.setThemeStyle(value!),
            ),
            RadioListTile<ThemeType>(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                AppLocalizations.of(context)!.light_theme,
              ),
              value: ThemeType.light,
              groupValue: themeVM.getThemeType(),
              onChanged: (value) => themeVM.setThemeStyle(value!),
            ),
            RadioListTile<ThemeType>(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                AppLocalizations.of(context)!.follow_the_system_settings,
              ),
              value: ThemeType.byDevice,
              groupValue: themeVM.getThemeType(),
              onChanged: (value) => themeVM.setThemeStyle(value!),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.close.toUpperCase(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
