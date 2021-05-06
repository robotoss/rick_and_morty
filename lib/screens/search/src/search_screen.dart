import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/components/loadings/loading_sliver.dart';
import 'package:rick_and_morty/components/text_filds/app_bar_search_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/screens/characters/character_list_item.dart';
import 'package:rick_and_morty/screens/search/feature.dart';
import 'package:rick_and_morty/screens/search/src/bloc/search_bloc.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';

class SearchScreen extends StatelessWidget {
  final SearchType searchType;
  const SearchScreen({Key? key, required this.searchType}) : super(key: key);

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
                _Body(
                  characters: state.characters,
                  searchType: searchType,
                ),
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
  final SearchType searchType;
  const _Body({
    Key? key,
    required this.characters,
    required this.searchType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return characters.isNotEmpty
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: CharacterListItem(character: characters[index]),
              ),
              childCount: characters.length,
            ),
          )
        : SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 50),
                _EmptyData(searchType: searchType)
              ],
            ),
          );
  }
}

class _EmptyData extends StatelessWidget {
  final SearchType searchType;
  const _EmptyData({Key? key, required this.searchType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (searchType) {
      case SearchType.character:
        return Column(
          children: [
            Image.asset('assets/images/no_characters.png'),
            const SizedBox(height: 28),
            SizedBox(
              width: 216,
              child: Text(
                AppLocalizations.of(context)!
                    .a_character_with_this_name_was_not_found,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        );
      case SearchType.episode:
        return Container();
      case SearchType.location:
        return Container();
    }
  }
}
