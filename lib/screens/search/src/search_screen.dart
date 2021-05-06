import 'package:flutter/material.dart';
import 'package:rick_and_morty/components/text_filds/app_bar_search_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _AppBar(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: AppBarSearchTextField(
        hintText: '',
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.search_results.toUpperCase(),
              style: AppTextStyles.subTitle,
            ),
          ),
        ),
      ),
    );
  }
}
