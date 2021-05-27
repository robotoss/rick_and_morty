import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/helpers/app_math.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';

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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('$index'),
                ),
                childCount: 100,
              ),
            )
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
          // child: ClipRRect(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          //     child: Container( 
          //       alignment: Alignment.center,
          //       color: AppColors.black.withOpacity(0.5),
          //     ),
          //   ),
          // ),
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
