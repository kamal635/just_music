import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/data/repository/fetch_songs_repo.dart';

part 'search_songs_event.dart';
part 'search_songs_state.dart';

class SearchSongsBloc extends Bloc<SearchSongsEvent, SearchSongsState> {
  final FetchSongsFromDeviceRepoImpl fetchSongsFromDeviceRepoImpl;
  List<Song> _allSongs = [];
  Timer? _debounce;

  SearchSongsBloc({required this.fetchSongsFromDeviceRepoImpl})
      : super(const SearchSongsState()) {
    on<SearchEvent>(_onSearchEvent);
    on<ResetSearchEvent>(_onResetSearchEvent);
    _fetchSongs();
  }

  Future<void> _fetchSongs() async {
    try {
      _allSongs = await fetchSongsFromDeviceRepoImpl.fetchSongsFromDevice();
    } catch (e) {
      // Handle error, possibly update the state with an error status
    }
  }

  void _onSearchEvent(
    SearchEvent event,
    Emitter<SearchSongsState> emit,
  ) async {
    // Cancel the previous debounce timer if it is still active
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set up a new debounce timer to delay the search action
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      // Emit a loading state while the search is being performed
      emit(state.copyWith(
        searchStatus: SearchStatus.loading,
      ));

      // Check if the search query is not empty
      if (event.query.isNotEmpty) {
        final queryLower = event.query
            .toLowerCase(); // Convert the query to lowercase for case-insensitive search
        final filterSongs = _allSongs.where((song) {
          return song.title
              .toLowerCase()
              .contains(queryLower); // Filter songs based on the query
        }).toList();
        // Emit the filtered list of songs and update the search status to loaded
        if (!emit.isDone) {
          emit(state.copyWith(
            songs: filterSongs,
            searchStatus: SearchStatus.loaded,
          ));
        }
      } else {
        // If the query is empty, emit an empty list of songs and set the search status to loaded
        if (!emit.isDone) {
          emit(state.copyWith(
            songs: [],
            searchStatus: SearchStatus.loaded,
          ));
        }
      }
    });

    // Await the debounce timer to ensure it completes before the handler finishes
    _debounce?.cancel();
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
