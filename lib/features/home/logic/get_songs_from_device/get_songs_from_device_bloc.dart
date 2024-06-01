import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/features/home/data/repository/get_all_songs_repo.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'get_songs_from_device_event.dart';
part 'get_songs_from_device_state.dart';

// BlocProvider instance in :
// lib\features\home\widgets\list_view_card_song.dart

class GetSongsFromDevice
    extends Bloc<GetSongsFromDeviceEvent, GetSongsFromDeviceState> {
  final GetSongsFromDeviceRepoImpl getAllSongsRepoImpl;

  GetSongsFromDevice({required this.getAllSongsRepoImpl})
      : super(const GetSongsFromDeviceState()) {
    on<TriggerGetSongsFromDeviceEvent>(_onTriggerGetAllSongsEvent);
  }

  void _onTriggerGetAllSongsEvent(
    TriggerGetSongsFromDeviceEvent event,
    Emitter<GetSongsFromDeviceState> emit,
  ) async {
    emit(state.copyWith(getSongsStatus: GetSongsStatus.loading));

    try {
      final listSongs = await getAllSongsRepoImpl.getAllSongs();

      emit(state.copyWith(
          getSongsStatus: GetSongsStatus.loaded, songModel: listSongs));
    } catch (err) {
      emit(state.copyWith(
          getSongsStatus: GetSongsStatus.failure,
          errorMessage: err.toString()));
    }
  }
}
