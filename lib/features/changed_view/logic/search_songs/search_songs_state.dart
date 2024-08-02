part of 'search_songs_bloc.dart';

enum SearchStatus { initial, loading, loaded, failure }

class SearchSongsState extends Equatable {
  final List<Song>? songs;
  final SearchStatus searchStatus;

  const SearchSongsState({
    this.songs,
    this.searchStatus = SearchStatus.initial,
  });

  SearchSongsState copyWith({
    List<Song>? songs,
    SearchStatus? searchStatus,
  }) {
    return SearchSongsState(
      songs: songs ?? this.songs,
      searchStatus: searchStatus ?? this.searchStatus,
    );
  }

  @override
  List<Object?> get props => [songs, searchStatus];
}
