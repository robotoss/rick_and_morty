import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/components/loadings/loading_sliver.dart';
import 'package:rick_and_morty/components/text_filds/app_bar_search_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/screens/character_info/feature.dart';
import 'package:rick_and_morty/screens/characters/character_list_item.dart';
import 'package:rick_and_morty/screens/search/src/bloc/search_bloc.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';
import 'package:rick_and_morty/data/extensions/character_extentions.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _AppBar(),
              if (state is SearchLoadingState) LoadingSliver(),
              if (state is SearchActiveState)
                _Body(characters: state.characters),
            ],
          );
        },
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
        onTextEnter: (searchText) => context
            .read<SearchBloc>()
            .add(GetSearchResultEvent(searchText: searchText)),
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

class _Body extends StatelessWidget {
  final List<Character> characters;
  const _Body({Key? key, required this.characters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          title: CharacterListItem(character: characters[index]),
        ),
        childCount: characters.length,
      ),
    );
  }
}
