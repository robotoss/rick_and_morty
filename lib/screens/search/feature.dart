import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/data/repository/repository.dart';

import 'src/bloc/search_bloc.dart';
import 'src/search_screen.dart';

enum SearchType { character, location, episode }

MaterialPageRoute searchRoute(SearchType searchType) {
  return MaterialPageRoute(
    builder: (context) {
      return BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(
          repository: context.read<Repository>(),
          searchType: searchType,
        ),
        child: SearchScreen(),
      );
    },
  );
}
