import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/components/buttons/search_button.dart';
import 'package:rick_and_morty/components/dialogs/error_snak_bar.dart';
import 'package:rick_and_morty/components/loadings/loading_sliver.dart';
import 'package:rick_and_morty/data/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/episodes_bloc.dart';
import 'view_model.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EpisodesBloc(
        repository: context.read<Repository>(),
      ),
      child: ChangeNotifierProvider(
        create: (_) => EpisodesViewModel(),
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
              body: BlocConsumer<EpisodesBloc, EpisodesState>(
            listener: (context, state) {
              if (state is EpisodesFailureState) {
                showErrorSnakBar(context, state.message);
              }
            },
            buildWhen: (_, current) => current is! EpisodesFailureState,
            builder: (context, state) {
              return NestedScrollView(
                floatHeaderSlivers: true,
                controller:
                    Provider.of<EpisodesViewModel>(context).addScrollListener(
                  () {},
                ),
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    [_AppBar()],
                body: _BodyList(),
                // slivers: [
                //   _AppBar(),
                //   // if (state is EpisodesInitialState) LoadingSliver(),
                //   // if (state is EpisodesDataState) _BodyList(),
                //   _BodyList()
                // ],
              );
            },
          )),
        ),
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
      title: SearchFilterButton(
        title: AppLocalizations.of(context)!.episodes,
        onTap: () {},
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TabBar(tabs: [
            Text('1'),
            Text('2'),
            Text('3'),
            Text('4'),
          ]),
        ),
      ),
    );
  }
}

class _BodyList extends StatelessWidget {
  const _BodyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => Text('$index'),
      ),
      Text('2'),
      Text('3'),
      Text('4'),
      // SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (context, index) => Text('123'),
      //     childCount: 40,
      //   ),
      // ),
      // SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (context, index) => Text('123'),
      //     childCount: 40,
      //   ),
      // ),
      // SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (context, index) => Text('123'),
      //     childCount: 40,
      //   ),
      // ),
      // SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (context, index) => Text('123'),
      //     childCount: 40,
      //   ),
      // ),
    ]);
  }
}
