import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/features/albums/data/repo/fetch_songs_album.dart';
import 'package:just_music/features/songs/data/model/song.dart';

part 'songs_albums_event.dart';
part 'songs_albums_state.dart';

class SongsAlbumsBloc extends Bloc<SongsAlbumsEvent, SongsAlbumsState> {
  final FetchSongsAlbumImpl fetchSongsAlbumImpl;

  SongsAlbumsBloc({required this.fetchSongsAlbumImpl})
      : super(const SongsAlbumsState()) {
    on<LoadSongsAlbumByIdEvent>(_onLoadSongsAlbumByIdEvent);
  }

  void _onLoadSongsAlbumByIdEvent(
    LoadSongsAlbumByIdEvent event,
    Emitter<SongsAlbumsState> emit,
  ) async {
    emit(state.copyWith(songsAlbumStatus: SongsAlbumStatus.loading));
    try {
      final listSongsAlbum = await fetchSongsAlbumImpl.fetchSongsAlbum(
        event.albumId,
      );

      emit(state.copyWith(
        songsAlbumStatus: SongsAlbumStatus.loaded,
        songs: List.from(state.songs.toList())..addAll(listSongsAlbum),
      ));
    } catch (e) {
      emit(state.copyWith(songsAlbumStatus: SongsAlbumStatus.failure));
    }
  }
}
