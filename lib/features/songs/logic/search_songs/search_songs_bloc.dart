import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/data/repository/fetch_songs_repo.dart';

part 'search_songs_event.dart';
part 'search_songs_state.dart';

class SearchSongsBloc extends Bloc<SearchSongsEvent, SearchSongsState> {
  final FetchSongsFromDeviceRepoImpl fetchSongsFromDeviceRepoImpl;

  SearchSongsBloc({required this.fetchSongsFromDeviceRepoImpl})
      : super(const SearchSongsState()) {
    on<SearchEvent>(_onSearchEvent);
    on<ResetSearchEvent>(_onResetSearchEvent);
  }

  void _onSearchEvent(
    SearchEvent event,
    Emitter<SearchSongsState> emit,
  ) async {
    emit(state.copyWith(
      searchStatus: SearchStatus.loading,
    ));
    try {
      if (event.query.isNotEmpty) {
        List<Song> songs =
            await fetchSongsFromDeviceRepoImpl.fetchSongsFromDevice();

        final filterSongs = songs
            .where((song) => song.title.toLowerCase().contains(event.query))
            .toList();
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
    } catch (e) {
      emit(state.copyWith(
        searchStatus: SearchStatus.failure,
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
