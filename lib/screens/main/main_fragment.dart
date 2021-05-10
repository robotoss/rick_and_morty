import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/screens/characters/character_list_screen.dart';
import 'package:rick_and_morty/screens/episodes/episodes_screen.dart';
import 'package:rick_and_morty/screens/main/view_model.dart';
import 'package:rick_and_morty/screens/settings/settings_screen.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainFragment extends StatelessWidget {
  const MainFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainViewModel(),
      child: Scaffold(
        body: _Body(),
        bottomNavigationBar: _BottomNavBar(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainViewModel>(context);
    return StreamBuilder<int>(
      stream: vm.getIndexScreen,
      initialData: 0,
      builder: (_, snapshot) {
        return IndexedStack(
          index: snapshot.data,
          children: <Widget>[
            Navigator(
              key: vm.navigatorKeys[0],
              observers: [HeroController()],
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => CharacterListScreen(),
              ),
            ),
            Navigator(
              key: vm.navigatorKeys[1],
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => Text('2'),
              ),
            ),
            Navigator(
              key: vm.navigatorKeys[2],
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => EpisodesScreen(),
              ),
            ),
            Navigator(
              key: vm.navigatorKeys[3],
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (_) => SettingsScreen(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainViewModel>(context);
    return StreamBuilder<int>(
      stream: vm.getIndexScreen,
      initialData: 0,
      builder: (_, snapshot) {
        return BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(RickMorty.ghost),
              label: AppLocalizations.of(context)!.characters,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(RickMorty.planet),
              ),
              label: AppLocalizations.of(context)!.location,
            ),
            BottomNavigationBarItem(
              icon: Icon(RickMorty.tv),
              label: AppLocalizations.of(context)!.episodes,
            ),
            BottomNavigationBarItem(
              icon: Icon(RickMorty.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
          currentIndex: snapshot.data!,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (newIndex) => vm.changeIndexScreen(newIndex),
        );
      },
    );
  }
}
