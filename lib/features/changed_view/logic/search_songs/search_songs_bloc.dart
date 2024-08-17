import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../songs/data/model/song.dart';
import '../../../songs/data/repository/fetch_songs_repo.dart';
import 'package:rxdart/rxdart.dart';

part 'search_songs_event.dart';
part 'search_songs_state.dart';

class SearchSongsBloc extends Bloc<SearchSongsEvent, SearchSongsState> {
  final FetchSongsFromDeviceRepoImpl fetchSongsFromDeviceRepoImpl;
  List<Song> _allSongs = [];
  bool _isFetched = false; // To check if songs are already fetched

  SearchSongsBloc({required this.fetchSongsFromDeviceRepoImpl})
      : super(const SearchSongsState()) {
    on<SearchEvent>(_onSearchEvent,
        transformer: debounce(const Duration(milliseconds: 300)));
    on<ResetSearchEvent>(_onResetSearchEvent);
  }

  void _onSearchEvent(
    SearchEvent event,
    Emitter<SearchSongsState> emit,
  ) async {
    // Emit loading state only if the search is new and not cached
    if (!_isFetched) {
      emit(state.copyWith(
        searchStatus: SearchStatus.loading,
      ));

      _allSongs = await fetchSongsFromDeviceRepoImpl.fetchSongsFromDevice();
      _isFetched = true; // Mark as fetched to avoid redundant fetches
    }

    if (event.query.isNotEmpty) {
      final queryLower = event.query.toLowerCase();

      final filterSongs = _allSongs.where((song) {
        return song.title.toLowerCase().contains(queryLower);
      }).toList(growable: false); // Avoid growing the list after filtering

      // Emit only if the result changes
      if (filterSongs.isNotEmpty) {
        emit(state.copyWith(
          songs: filterSongs,
          searchStatus: SearchStatus.loaded,
        ));
      } else {
        emit(state.copyWith(
          searchStatus: SearchStatus.notResault,
        ));
      }
    } else {
      // Clear search results only if it’s necessary
      if (state.songs!.isNotEmpty ||
          state.searchStatus != SearchStatus.loaded) {
        emit(state.copyWith(
          songs: [],
          searchStatus: SearchStatus.loaded,
        ));
      }
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

  EventTransformer<SearchEvent> debounce<SearchEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }
}
