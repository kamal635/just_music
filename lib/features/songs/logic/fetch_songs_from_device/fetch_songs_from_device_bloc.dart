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

  FetchSongsFromDeviceBloc({required this.fetchSongsFromDeviceRepoImpl})
      : super(const FetchSongsFromDeviceState()) {
    on<LoadSongsFromDeviceEvent>(_onLoadSongsFromDeviceEvent);
  }

  void _onLoadSongsFromDeviceEvent(
    LoadSongsFromDeviceEvent event,
    Emitter<FetchSongsFromDeviceState> emit,
  ) async {
    emit(state.copyWith(fetchSongsStatus: FetchSongsStatus.loading));

    try {
      List<Song> songs =
          await fetchSongsFromDeviceRepoImpl.fetchSongsFromDevice();

      emit(state.copyWith(
        fetchSongsStatus: FetchSongsStatus.loaded,
        songs: songs,
      ));
    } catch (err) {
      emit(state.copyWith(
          fetchSongsStatus: FetchSongsStatus.failure,
          errorMessage: err.toString()));
    }
  }
}
