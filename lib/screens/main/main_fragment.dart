import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/screens/main/view_model.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';

class MainFragment extends StatelessWidget {
  const MainFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainViewModel(),
      child: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: _BottomNavBar(),
      ),
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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(RickMorty.ghost),
              label: 'Персонажи',
            ),
            BottomNavigationBarItem(
              icon: Icon(RickMorty.planet),
              label: 'Локациии',
            ),
            BottomNavigationBarItem(
              icon: Icon(RickMorty.tv),
              label: 'Эпизоды',
            ),
            BottomNavigationBarItem(
              icon: Icon(RickMorty.settings),
              label: 'Настройки',
            ),
          ],
          currentIndex: snapshot.data!,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          // selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.black.withOpacity(0.25),
          onTap: (newIndex) => vm.changeIndexScreen(newIndex),
        );
      },
    );
  }
}
