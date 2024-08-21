part of 'search_songs_bloc.dart';

enum SearchStatus { initial, loading, loaded, noResault, failure }

class SearchSongsState extends Equatable {
  final List<Song>? songs;
  final SearchStatus searchStatus;
  final String? errMessage;

  const SearchSongsState({
    this.songs,
    this.searchStatus = SearchStatus.initial,
    this.errMessage,
  });

  SearchSongsState copyWith({
    List<Song>? songs,
    SearchStatus? searchStatus,
    String? errMessage,
  }) {
    return SearchSongsState(
      songs: songs ?? this.songs,
      searchStatus: searchStatus ?? this.searchStatus,
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [songs, searchStatus, errMessage];
}
