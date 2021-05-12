import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/components/buttons/search_button.dart';
import 'package:rick_and_morty/components/dialogs/error_snak_bar.dart';
import 'package:rick_and_morty/components/loadings/portal_loading.dart';
import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';
import 'package:rick_and_morty/data/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';

import 'bloc/episodes_bloc.dart';
import 'view_model.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EpisodesBloc(
        repository: context.read<Repository>(),
      )..add(GetEpisodesEvent()),
      child: ChangeNotifierProvider(
        create: (_) => EpisodesViewModel(),
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: _AppBar(),
              body: BlocConsumer<EpisodesBloc, EpisodesState>(
                listener: (context, state) {
                  if (state is EpisodesFailureState) {
                    showErrorSnakBar(context, state.message);
                  }
                },
                buildWhen: (_, current) => current is! EpisodesFailureState,
                builder: (context, state) {
                  return _BodyList(state: state);
                },
              )),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SearchFilterButton(
        title: AppLocalizations.of(context)!.findTheEpisode,
        onTap: () {},
      ),
      bottom: TabBar(
        tabs: [
          for (final index in List<int>.generate(4, (i) => i + 1))
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                AppLocalizations.of(context)!.season(index).toUpperCase(),
              ),
            ),
        ],
      ),
    );
  }
}

class _BodyList extends StatelessWidget {
  final EpisodesState state;

  const _BodyList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        for (final index in List<int>.generate(4, (i) => i + 1))
          state is EpisodesDataState
              ? _EpisodesList(
                  state: state as EpisodesDataState,
                  season: index,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: PortalLoading(),
                )
      ],
    );
  }
}

class _EpisodesList extends StatelessWidget {
  final EpisodesDataState state;
  final int season;
  _EpisodesList({
    Key? key,
    required this.state,
    required this.season,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: state.episodes[season - 1].episodes.length,
      itemBuilder: (context, index) => _EpisodeItem(
        episode: state.episodes[season - 1].episodes[index],
      ),
    );
  }
}

class _EpisodeItem extends StatelessWidget {
  final Episodes episode;
  const _EpisodeItem({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
    );
  }
}
