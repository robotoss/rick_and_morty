part of 'search_bloc.dart';

abstract class SearchEvent {}

class GetSearchResultEvent extends SearchEvent {
  final String searchText;

  GetSearchResultEvent({required this.searchText});
}
