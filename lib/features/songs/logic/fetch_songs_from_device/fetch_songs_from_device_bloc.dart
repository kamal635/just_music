import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/song.dart';
import '../../data/repository/fetch_songs_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_songs_from_device_event.dart';
part 'fetch_songs_from_device_state.dart';

class FetchSongsFromDeviceBloc
    extends Bloc<FetchSongsFromDeviceEvent, FetchSongsFromDeviceState> {
  final FetchSongsFromDeviceRepoImpl fetchSongsFromDeviceRepoImpl;
  final List<Song> _allSongs = [];

  FetchSongsFromDeviceBloc({required this.fetchSongsFromDeviceRepoImpl})
      : super(const FetchSongsFromDeviceState()) {
    on<LoadSongsFromDeviceEvent>(_onLoadSongsFromDeviceEvent);
    on<LoadFixedSongsFromDeviceEvent>(_onLoadFixedSongsFromDeviceEvent);
    _preloadSongs();
  }

  Future<void> _preloadSongs() async {
    final songs = await fetchSongsFromDeviceRepoImpl.fetchSongs();
    _allSongs.addAll(songs);
  }

  void _onLoadSongsFromDeviceEvent(
    LoadSongsFromDeviceEvent event,
    Emitter<FetchSongsFromDeviceState> emit,
  ) async {
    emit(state.copyWith(fetchSongsStatus: FetchSongsStatus.loading));

    try {
      emit(state.copyWith(
        songs: _allSongs,
        fetchSongsStatus: FetchSongsStatus.loaded,
      ));
    } catch (err) {
      emit(state.copyWith(
        fetchSongsStatus: FetchSongsStatus.failure,
        errorMessage: err.toString(),
      ));
    }
  }

  void _onLoadFixedSongsFromDeviceEvent(
    LoadFixedSongsFromDeviceEvent event,
    Emitter<FetchSongsFromDeviceState> emit,
  ) async {
    emit(state.copyWith(fetchSongsStatus: FetchSongsStatus.loading));

    try {
      final fixedSongs = await fetchSongsFromDeviceRepoImpl.fetchFixedSongs();
      emit(state.copyWith(
        fixedSongs: fixedSongs,
        fetchSongsStatus: FetchSongsStatus.loaded,
      ));
    } catch (err) {
      emit(state.copyWith(
        fetchSongsStatus: FetchSongsStatus.failure,
        errorMessage: err.toString(),
      ));
    }
  }
}
