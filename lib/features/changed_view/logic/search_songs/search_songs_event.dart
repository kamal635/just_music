part of 'search_songs_bloc.dart';

sealed class SearchSongsEvent extends Equatable {
  const SearchSongsEvent();

  @override
  List<Object> get props => [];
}

class SearchEvent extends SearchSongsEvent {
  final String query;

  const SearchEvent({required this.query});
  @override
  List<Object> get props => [query];
}

class ResetSearchEvent extends SearchSongsEvent {}
