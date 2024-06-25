import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:just_music/features/home/data/repository/fetch_songs_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_songs_from_device_event.dart';
part 'fetch_songs_from_device_state.dart';

// BlocProvider instance in :
// lib\features\home\widgets\list_view_card_song.dart
class FetchSongsFromDeviceBloc
    extends Bloc<FetchSongsFromDeviceEvent, FetchSongsFromDeviceState> {
  final FetchSongsFromDeviceRepoImpl getAllSongsRepoImpl;

  FetchSongsFromDeviceBloc({required this.getAllSongsRepoImpl})
      : super(const FetchSongsFromDeviceState()) {
    on<LoadSongsFromDeviceEvent>(_onLoadSongsFromDeviceEvent);
  }

  void _onLoadSongsFromDeviceEvent(
    LoadSongsFromDeviceEvent event,
    Emitter<FetchSongsFromDeviceState> emit,
  ) async {
    emit(state.copyWith(fetchSongsStatus: FetchSongsStatus.loading));

    try {
      final listSongs = await getAllSongsRepoImpl.fetchSongsFromDevice();

      emit(state.copyWith(
          fetchSongsStatus: FetchSongsStatus.loaded, songModel: listSongs));
    } catch (err) {
      emit(state.copyWith(
          fetchSongsStatus: FetchSongsStatus.failure,
          errorMessage: err.toString()));
    }
  }
}
