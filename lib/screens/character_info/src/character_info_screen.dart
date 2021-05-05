import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/api/models/all_characters_model.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';

class CharacterInfoScreen extends StatelessWidget {
  final Character character;
  const CharacterInfoScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => ListTile(
                title: Text("Index: $index"),
              ),
            ),
          )
        ],
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
