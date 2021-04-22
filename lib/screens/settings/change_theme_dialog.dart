import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/data/helpers/theme_types.dart';

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
              groupValue: ThemeType.dark,
              onChanged: (value) {},
            ),
            RadioListTile<ThemeType>(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                AppLocalizations.of(context)!.light_theme,
              ),
              value: ThemeType.light,
              groupValue: ThemeType.dark,
              onChanged: (value) {},
            ),
            RadioListTile<ThemeType>(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                AppLocalizations.of(context)!.follow_the_system_settings,
              ),
              value: ThemeType.byDevice,
              groupValue: ThemeType.dark,
              onChanged: (value) {},
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
