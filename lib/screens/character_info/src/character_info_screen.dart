import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/components/dialogs/error_snak_bar.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/data/api/models/episodes_model.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/screens/episode_info/feature.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/data/extensions/character_extentions.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/character_info_bloc.dart';

class CharacterInfoScreen extends StatelessWidget {
  final Character character;
  const CharacterInfoScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharacterInfoBloc, CharacterInfoState>(
      listener: (context, state) {
        if (state is CharacterInfoFailureState) {
          showErrorSnakBar(context, state.message);
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: _AppBar(
                character: character,
                expandedHeight: 218,
                safeAreaSize: MediaQuery.of(context).padding.top,
              ),
              pinned: true,
            ),
            _CharacterStartInfo(character: character),
            _CharacterLocationInfo(character: character),
            _Episodes()
          ],
        ),
      ),
    );
  }
}

double setAvatarOpacity(double shrinkOffset, double expandedHeight) {
  final opacity = 1 - shrinkOffset / (expandedHeight / 3);
  return opacity >= 0 ? opacity : 0;
}

class _AppBar extends SliverPersistentHeaderDelegate {
  final Character character;
  final double expandedHeight;
  final double safeAreaSize;

  _AppBar({
    required this.expandedHeight,
    required this.character,
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
              image: NetworkImage(character.image),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                alignment: Alignment.center,
                color: AppColors.black.withOpacity(0.5),
              ),
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
          top: expandedHeight - 90 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 2 - 90,
          child: Opacity(
            opacity: setAvatarOpacity(shrinkOffset, expandedHeight),
            child: Container(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              child: Hero(
                tag: 'CharacterAvatar_${character.id}',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(character.image),
                ),
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

class _CharacterStartInfo extends StatelessWidget {
  final Character character;
  const _CharacterStartInfo({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 90),
            Text(
              character.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 4),
            Text(
              character.status.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .overline!
                  .copyWith(color: character.statusColor),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _StartInfoItem(
                    title: AppLocalizations.of(context)!.gender,
                    value: character.gender,
                  ),
                ),
                Expanded(
                  child: _StartInfoItem(
                    title: AppLocalizations.of(context)!.race,
                    value: character.species,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _StartInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const _StartInfoItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class _CharacterLocationInfo extends StatelessWidget {
  final Character character;
  const _CharacterLocationInfo({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 10),
          _CharacterLocationInfoItem(
            title: AppLocalizations.of(context)!.location,
            value: character.origin,
          ),
          const SizedBox(height: 4),
          _CharacterLocationInfoItem(
            title: AppLocalizations.of(context)!.locality,
            value: character.location,
          ),
          const SizedBox(height: 26),
          const Divider(
            thickness: 2,
            height: 2,
          ),
        ],
      ),
    );
  }
}

class _CharacterLocationInfoItem extends StatelessWidget {
  final String title;
  final Location value;
  const _CharacterLocationInfoItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  value.name,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 10),
              ],
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

class _Episodes extends StatelessWidget {
  const _Episodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterInfoBloc, CharacterInfoState>(
      buildWhen: (_, current) => current is! CharacterInfoFailureState,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.episodes,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            AppLocalizations.of(context)!.all_episodes,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      state is CharacterInfoEpisodesState
                          ? _EpisodeItem(
                              episode: state.episodes[index],
                            )
                          : _LoadingEpisodeItem(),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: state is CharacterInfoEpisodesState
                      ? _EpisodeItem(
                          episode: state.episodes[index],
                        )
                      : _LoadingEpisodeItem(),
                );
              }
            },
            childCount:
                state is CharacterInfoEpisodesState ? state.episodes.length : 4,
          ),
        );
      },
    );
  }
}

class _EpisodeItem extends StatelessWidget {
  final Episode episode;
  const _EpisodeItem({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () => Navigator.of(context, rootNavigator: true).push(
          episodeInfoRoute(episode as Episode),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 74,
                width: 74,
                child: Image.asset(
                  'assets/images/episodes/${episode.episode}.jpg',
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Theme.of(context).accentColor,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.episode,
                    style: AppTextStyles.infoItemTitle.copyWith(
                      color: AppColors.lightBlue.withOpacity(0.87),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    episode.name,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.infoItemValue,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    episode.airDate,
                    style: AppTextStyles.infoItemDate.copyWith(
                      color: AppColors.subTitle,
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
            Container(
              height: 74,
              width: 74,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
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
