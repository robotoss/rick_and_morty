import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/components/loadings/portal_loading.dart';
import 'package:rick_and_morty/components/text_filds/app_bar_search_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/data/api/models/all_characters_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';
import 'character_extentions.dart';

import 'bloc/characters_bloc.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(
        repository: context.read<Repository>(),
      )..add(GetAllCharactersEvent()),
      child: Scaffold(
          body: BlocConsumer<CharactersBloc, CharactersState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _AppBar(),
              if (state is CharactersInitialState) _LoadingBody(),
              if (state is CharactersDataState)
                _BodyList(
                  characters: state.characters,
                )
            ],
          );
        },
      )),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                AppLocalizations.of(context)!.total_characters(100),
                style: AppTextStyles.subTitle,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  RickMorty.grid,
                  color: Theme.of(context).textTheme.overline!.color,
                ),
              )
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          title: _CharacterItem(character: characters[index]),
        ),
        childCount: characters.length,
      ),
    );
  }
}

class _CharacterItem extends StatelessWidget {
  final Character character;
  const _CharacterItem({Key? key, required this.character}) : super(key: key);

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
          Column(
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
