import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/features/artists/data/repo/fetch_songs_artist.dart';
import 'package:just_music/features/songs/data/model/song.dart';

part 'songs_artist_event.dart';
part 'songs_artist_state.dart';

class SongsArtistBloc extends Bloc<SongsArtistEvent, SongsArtistState> {
  final FetchSongsArtistImpl fetchSongsArtistImpl;

  SongsArtistBloc({required this.fetchSongsArtistImpl})
      : super(const SongsArtistState()) {
    on<LoadSongsArtistByIdEvent>(_onLoadSongsArtistEvent);
  }

  void _onLoadSongsArtistEvent(
    LoadSongsArtistByIdEvent event,
    Emitter<SongsArtistState> emit,
  ) async {
    emit(state.copyWith(songsArtistStatus: SongsArtistStatus.loading));
    try {
      final listSongsArtist =
          await fetchSongsArtistImpl.fetchSongsArtist(event.artistId);
      emit(state.copyWith(
          songsArtistStatus: SongsArtistStatus.loaded, songs: listSongsArtist));
    } catch (e) {
      emit(state.copyWith(songsArtistStatus: SongsArtistStatus.failure));
    }
  }
}
