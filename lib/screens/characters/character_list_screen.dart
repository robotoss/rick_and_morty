import 'package:flutter/material.dart';
import 'package:rick_and_morty/components/text_filds/app_bar_search_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AppBarSearchTextField(
                hintText: AppLocalizations.of(context)!.find_a_character,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
