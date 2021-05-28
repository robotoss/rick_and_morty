import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/helpers/app_math.dart';
import 'package:rick_and_morty/screens/character_info/feature.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rick_and_morty/data/extensions/character_extentions.dart';

import 'bloc/episode_info_bloc.dart';

class EpisodeInfoScreen extends StatelessWidget {
  final Episode episode;
  const EpisodeInfoScreen({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EpisodeInfoBloc, EpisodeInfoState>(
      listener: (context, state) {
        // if (state is EpisodeInfoFailureState) {
        //   showErrorSnakBar(context, state.message);
        // }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: _AppBar(
                episode: episode,
                expandedHeight: 300,
                safeAreaSize: MediaQuery.of(context).padding.top + 30,
              ),
              pinned: true,
            ),
            _EpisodeTitle(episode: episode),
            _Divider(),
            _Characters(),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends SliverPersistentHeaderDelegate {
  final Episode episode;
  final double expandedHeight;
  final double safeAreaSize;

  _AppBar({
    required this.expandedHeight,
    required this.episode,
    required this.safeAreaSize,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/images/episodes/${episode.episode}.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).dividerColor,
                ),
                child: Icon(
                  RickMorty.arrow_left,
                  size: 14,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: (expandedHeight - 30 - shrinkOffset) >
                  MediaQuery.of(context).padding.top + 60
              ? expandedHeight - 30 - shrinkOffset
              : MediaQuery.of(context).padding.top + 60,
          left: 0,
          right: 0,
          child: Container(
            height: 32,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        Positioned(
          top: expandedHeight - 80 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: Opacity(
            opacity: setAvatarOpacity(shrinkOffset, expandedHeight),
            child: Container(
              height: 99,
              width: 99,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightBlue,
              ),
              child: Center(
                child: Icon(RickMorty.play),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + safeAreaSize;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _EpisodeTitle extends StatelessWidget {
  final Episode episode;
  const _EpisodeTitle({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              episode.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 4),
            Text(
              episode.episode,
              style: Theme.of(context).textTheme.overline,
            ),
            const SizedBox(height: 36),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.premiere,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                episode.airDate,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: const Divider(
        thickness: 2,
        height: 2,
      ),
    );
  }
}

class _Characters extends StatelessWidget {
  const _Characters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeInfoBloc, EpisodeInfoState>(
      buildWhen: (_, current) => current is! EpisodeInfoFailureState,
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 36),
                      Text(
                        AppLocalizations.of(context)!.characters,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 12),
                      state is EpisodeInfoEpisodesState
                          ? _CharacterItem(
                              character: state.characters[index],
                            )
                          : _LoadingEpisodeItem(),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: state is EpisodeInfoEpisodesState
                      ? _CharacterItem(
                          character: state.characters[index],
                        )
                      : _LoadingEpisodeItem(),
                );
              }
            },
            childCount:
                state is EpisodeInfoEpisodesState ? state.characters.length : 4,
          ),
        );
      },
    );
  }
}

class _CharacterItem extends StatelessWidget {
  final Character character;
  const _CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
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
                    style: AppTextStyles.infoItemTitle
                        .copyWith(color: character.statusColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    character.name,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.infoItemValue,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${character.species} ${character.gender}',
                    style: AppTextStyles.infoItemDate.copyWith(
                      color: AppColors.subTitle,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(
              RickMorty.forward,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingEpisodeItem extends StatelessWidget {
  const _LoadingEpisodeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Shimmer.fromColors(
        baseColor: AppColors.gray.withOpacity(0.1),
        highlightColor: Theme.of(context).accentColor,
        enabled: true,
        child: Row(
          children: [
            CircleAvatar(
              radius: 37,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Text(
                      'Episode 1',
                      style: AppTextStyles.infoItemTitle,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    color: Colors.white,
                    child: Text(
                      'Some Episode Name',
                      textAlign: TextAlign.start,
                      style: AppTextStyles.infoItemValue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    color: Colors.white,
                    child: Text(
                      '22 september 2013',
                      style: AppTextStyles.infoItemDate,
                    ),
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
