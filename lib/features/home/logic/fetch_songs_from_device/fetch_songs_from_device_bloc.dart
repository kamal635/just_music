import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:just_music/features/home/data/repository/get_all_songs_repo.dart';
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
    emit(state.copyWith(getSongsStatus: GetSongsStatus.loading));

    try {
      final listSongs = await getAllSongsRepoImpl.getSongsFromDevice();

      emit(state.copyWith(
          getSongsStatus: GetSongsStatus.loaded, songModel: listSongs));
    } catch (err) {
      emit(state.copyWith(
          getSongsStatus: GetSongsStatus.failure,
          errorMessage: err.toString()));
    }
  }
}
