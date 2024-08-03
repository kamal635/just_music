import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/data/repository/fetch_songs_repo.dart';

part 'search_songs_event.dart';
part 'search_songs_state.dart';

class SearchSongsBloc extends Bloc<SearchSongsEvent, SearchSongsState> {
  final FetchSongsFromDeviceRepoImpl fetchSongsFromDeviceRepoImpl;
  final List<Song> _allSongs = [];

  SearchSongsBloc({required this.fetchSongsFromDeviceRepoImpl})
      : super(const SearchSongsState()) {
    on<SearchEvent>(_onSearchEvent);
    on<ResetSearchEvent>(_onResetSearchEvent);
  }

  void _onSearchEvent(
    SearchEvent event,
    Emitter<SearchSongsState> emit,
  ) async {
    // Emit a loading state while the search is being performed
    emit(state.copyWith(
      searchStatus: SearchStatus.loading,
    ));

    final songs = await fetchSongsFromDeviceRepoImpl.fetchSongsFromDevice();
    _allSongs.addAll(songs);
    // Check if the search query is not empty
    if (event.query.isNotEmpty) {
      final queryLower = event.query
          .toLowerCase(); // Convert the query to lowercase for case-insensitive search
      final filterSongs = _allSongs.where((song) {
        return song.title
            .toLowerCase()
            .contains(queryLower); // Filter songs based on the query
      }).toList();

      emit(state.copyWith(
        songs: filterSongs,
        searchStatus: SearchStatus.loaded,
      ));
    } else {
      emit(state.copyWith(
        songs: [],
        searchStatus: SearchStatus.loaded,
      ));
    }
  }

  void _onResetSearchEvent(
    ResetSearchEvent event,
    Emitter<SearchSongsState> emit,
  ) {
    emit(const SearchSongsState(
      songs: [],
      searchStatus: SearchStatus.initial,
    ));
  }
}
