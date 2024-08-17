import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/core/helpers/cached_song.dart';
import '../../data/repo/fetch_songs_album.dart';
import '../../../songs/data/model/song.dart';

part 'songs_albums_event.dart';
part 'songs_albums_state.dart';

class SongsAlbumsBloc extends Bloc<SongsAlbumsEvent, SongsAlbumsState> {
  final FetchSongsAlbumImpl fetchSongsAlbumImpl;
  final CachedSongs cachedSongs;

  SongsAlbumsBloc(
      {required this.fetchSongsAlbumImpl, required this.cachedSongs})
      : super(const SongsAlbumsState()) {
    on<LoadSongsAlbumByIdEvent>(_onLoadSongsAlbumByIdEvent);
  }

  void _onLoadSongsAlbumByIdEvent(
    LoadSongsAlbumByIdEvent event,
    Emitter<SongsAlbumsState> emit,
  ) async {
    emit(state.copyWith(songsAlbumStatus: SongsAlbumStatus.loading));

    // Check if songs are already cached
    final cachedSongsList = cachedSongs.getSongs(event.albumId);
    if (cachedSongsList.isNotEmpty) {
      emit(state.copyWith(
        songsAlbumStatus: SongsAlbumStatus.loaded,
        songs: cachedSongsList,
      ));
      return; // Exit the function, no need to fetch from the device
    }

    try {
      // Fetch songs from device
      final listSongsAlbum = await fetchSongsAlbumImpl.fetchSongsAlbum(
        event.albumId,
      );

      // Cache the songs
      cachedSongs.setSongs(listSongsAlbum, event.albumId);

      emit(state.copyWith(
        songsAlbumStatus: SongsAlbumStatus.loaded,
        songs: listSongsAlbum,
      ));
    } catch (e) {
      emit(state.copyWith(songsAlbumStatus: SongsAlbumStatus.failure));
    }
  }
}
