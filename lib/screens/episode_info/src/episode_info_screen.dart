import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/helpers/app_math.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            _Divider()
          ],
        ),
      ),
    );
  }
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
