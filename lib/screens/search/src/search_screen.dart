import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/components/text_filds/app_bar_search_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/screens/character_info/feature.dart';
import 'package:rick_and_morty/screens/search/src/bloc/search_bloc.dart';
import 'package:rick_and_morty/screens/search/src/view_model.dart';
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
    final vm = Provider.of<SearchViewModel>(context);
    return SliverAppBar(
      floating: true,
      title: AppBarSearchTextField(
        hintText: '',
        textEditingController: vm.addTextEditingController(
          (searchText) => context.read<SearchBloc>().add(
                GetSearchResultEvent(searchText: searchText),
              ),
        ),
        focusNode: vm.searchFocusNode,
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
          title: _CharacterListItem(character: characters[index]),
        ),
        childCount: characters.length,
      ),
    );
  }
}

class _CharacterListItem extends StatelessWidget {
  final Character character;
  const _CharacterListItem({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Navigator.of(context, rootNavigator: true).push(
          characterInfoRoute(character),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'CharacterAvatar_${character.id}',
              child: CircleAvatar(
                radius: 37,
                backgroundImage: NetworkImage(character.image),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.status.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .overline!
                        .copyWith(color: character.statusColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    character.name,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.charName.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${character.species}, ${character.gender}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
