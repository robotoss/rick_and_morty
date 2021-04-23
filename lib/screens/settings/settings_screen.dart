import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';

import 'change_theme_dialog.dart';
import 'view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
      builder: (_, child) => Scaffold(
        appBar: _AppBar(),
        body: _Body(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.settings),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _MenuItem(
              title: AppLocalizations.of(context)!.appearance,
              child: const _Appearance(),
            ),
            _MenuItem(
              title: AppLocalizations.of(context)!.about_the_app,
              child: const _AboutApp(),
            ),
            _MenuItem(
              title: AppLocalizations.of(context)!.application_version,
              child: const _AppVersion(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final Widget child;
  const _MenuItem({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 36),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.overline,
        ),
        const SizedBox(height: 24),
        child,
        const SizedBox(height: 36),
        Divider(
          thickness: 1,
          height: 2,
        ),
      ],
    );
  }
}

class _Appearance extends StatelessWidget {
  const _Appearance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showChangeThemeDialog(context),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        children: [
          Icon(RickMorty.color_palette),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.the_color_theme_of_the_app,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                AppLocalizations.of(context)!.dark_theme,
                style: AppTextStyles.subTitle,
              ),
            ],
          ),
          const Spacer(),
          Icon(
            RickMorty.forward,
            size: 12,
          ),
        ],
      ),
    );
  }
}

class _AboutApp extends StatelessWidget {
  const _AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.the_zigerionists_put_jerry_and_rick,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}

class _AppVersion extends StatelessWidget {
  const _AppVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SettingsViewModel>();
    return StreamBuilder<String>(
      stream: vm.getAppVersion,
      initialData: '',
      builder: (_, snapshot) {
        return Text(
          'Rick & Morty ${snapshot.data}',
          style: Theme.of(context).textTheme.subtitle1,
        );
      },
    );
  }
}
