import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/components/loadings/portal_loading.dart';
import 'package:rick_and_morty/components/text_filds/app_bar_search_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/data/api/models/all_characters_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';
import 'character_extentions.dart';

import 'bloc/characters_bloc.dart';
import 'view_model.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(
        repository: context.read<Repository>(),
      )..add(GetAllCharactersEvent()),
      child: ChangeNotifierProvider(
        create: (_) => CharactersViewModel(),
        child: Scaffold(
            body: BlocConsumer<CharactersBloc, CharactersState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return CustomScrollView(
              controller:
                  Provider.of<CharactersViewModel>(context).addScrollListener(
                () => context
                    .read<CharactersBloc>()
                    .add(GetMoreCharactersEvent()),
              ),
              slivers: [
                _AppBar(
                  charactersCount:
                      state is CharactersDataState ? state.charactersCount : 0,
                ),
                if (state is CharactersInitialState) _LoadingBody(),
                if (state is CharactersDataState)
                  _BodyList(
                    characters: state.characters,
                  )
              ],
            );
          },
        )),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final int charactersCount;
  const _AppBar({Key? key, required this.charactersCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CharactersViewModel>(context);
    return SliverAppBar(
      floating: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            AppBarSearchTextField(
              hintText: AppLocalizations.of(context)!.find_a_character,
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.total_characters(charactersCount),
                style: AppTextStyles.subTitle,
              ),
              StreamBuilder<bool>(
                stream: vm.getIsColumnType,
                initialData: false,
                builder: (_, snapshot) {
                  return IconButton(
                    onPressed: () => vm.changeListViewType(),
                    icon: Icon(
                      snapshot.data! ? RickMorty.grid : RickMorty.list,
                      size: 18,
                      color: Theme.of(context).textTheme.overline!.color,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: PortalLoading(),
      ),
    );
  }
}

class _BodyList extends StatelessWidget {
  final List<Character> characters;
  const _BodyList({Key? key, required this.characters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CharactersViewModel>(context);
    return StreamBuilder<bool>(
      stream: vm.getIsColumnType,
      initialData: true,
      builder: (_, snapshot) {
        return snapshot.data!
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                    title: _CharacterListItem(character: characters[index]),
                  ),
                  childCount: characters.length,
                ),
              )
            : SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        MediaQuery.of(context).size.width / 2 / 192,
                    mainAxisExtent: 239),
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _CharacterGridItem(character: characters[index]),
                  childCount: characters.length,
                ),
              );
      },
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 37,
            backgroundImage: NetworkImage(character.image),
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
    );
  }
}

class _CharacterGridItem extends StatelessWidget {
  final Character character;
  const _CharacterGridItem({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(character.image),
          ),
          const SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                textAlign: TextAlign.center,
                maxLines: 2,
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
          )
        ],
      ),
    );
  }
}
