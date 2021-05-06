// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';

// class SearchViewModel extends ChangeNotifier {
//   SearchViewModel() {
//     searchTextController.addListener(() {
//       _searchText.add(searchTextController.text);
//     });
//   }

//   final searchTextController = TextEditingController();
//   final searchFocusNode = FocusNode();

//   final _searchText = BehaviorSubject<String>();

//   TextEditingController addTextEditingController(
//       Function(String searchText) onSearch) {
//     if (!_searchText.hasListener) {
//       _searchText.debounceTime(const Duration(seconds: 1)).listen((text) {
//         onSearch(text);
//       });
//     }
//     return searchTextController;
//   }

//   @override
//   void dispose() {
//     _searchText.close();
//     super.dispose();
//   }
// }
