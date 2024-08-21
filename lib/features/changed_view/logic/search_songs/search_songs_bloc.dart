import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/features/changed_view/data/search_repository.dart';
import '../../../songs/data/model/song.dart';

part 'search_songs_event.dart';
part 'search_songs_state.dart';

class SearchSongsBloc extends Bloc<SearchSongsEvent, SearchSongsState> {
  final SearchRepoImpl searchRepoImpl;
  final List<Song> _allSongs = [];

  SearchSongsBloc({required this.searchRepoImpl})
      : super(const SearchSongsState()) {
    on<SearchEvent>(_onSearch);
    on<ResetSearchEvent>(_onReset);

    _preloadSongs();
  }

  Future<void> _preloadSongs() async {
    final songs = await searchRepoImpl.preloadSongs();
    _allSongs.addAll(songs);
  }

  void _onSearch(
    SearchEvent event,
    Emitter<SearchSongsState> emit,
  ) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(songs: [], searchStatus: SearchStatus.initial));
      return;
    }

    final filteredSongs = _allSongs
        .where((song) => song.title.toLowerCase().contains(query))
        .toList();

    if (filteredSongs.isNotEmpty) {
      emit(state.copyWith(
          songs: filteredSongs, searchStatus: SearchStatus.loaded));
    } else {
      emit(state.copyWith(searchStatus: SearchStatus.noResault));
    }
  }

  void _onReset(
    ResetSearchEvent event,
    Emitter<SearchSongsState> emit,
  ) {
    emit(const SearchSongsState());
  }
}
