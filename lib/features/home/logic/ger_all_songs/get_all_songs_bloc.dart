import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/features/home/data/repository/get_all_songs_repo.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'get_all_songs_event.dart';
part 'get_all_songs_state.dart';

class GetAllSongsBloc extends Bloc<GetAllSongsEvent, GetAllSongsState> {
  final GetAllSongsRepoImpl getAllSongsRepoImpl;

  GetAllSongsBloc({required this.getAllSongsRepoImpl})
      : super(const GetAllSongsState()) {
    on<TriggerGetAllSongsEvent>(_onTriggerGetAllSongsEvent);
  }

  void _onTriggerGetAllSongsEvent(
    TriggerGetAllSongsEvent event,
    Emitter<GetAllSongsState> emit,
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
