import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/core/helpers/cached_song.dart';
import '../../data/repo/fetch_songs_artist.dart';
import '../../../songs/data/model/song.dart';

part 'songs_artist_event.dart';
part 'songs_artist_state.dart';

class SongsArtistBloc extends Bloc<SongsArtistEvent, SongsArtistState> {
  final FetchSongsArtistImpl fetchSongsArtistImpl;
  final CachedSongs cachedSongs;

  SongsArtistBloc(
      {required this.fetchSongsArtistImpl, required this.cachedSongs})
      : super(const SongsArtistState()) {
    on<LoadSongsArtistByIdEvent>(_onLoadSongsArtistEvent);
  }

  void _onLoadSongsArtistEvent(
    LoadSongsArtistByIdEvent event,
    Emitter<SongsArtistState> emit,
  ) async {
    emit(state.copyWith(songsArtistStatus: SongsArtistStatus.loading));

    // Check if songs are already cached
    final cachedSongsList = cachedSongs.getSongs(event.artistId);
    if (cachedSongsList.isNotEmpty) {
      emit(state.copyWith(
        songsArtistStatus: SongsArtistStatus.loaded,
        songs: cachedSongsList,
      ));
      return; // Exit the function, no need to fetch from the device
    }

    try {
      // Fetch songs from device
      final listSongsArtist = await fetchSongsArtistImpl.fetchSongsArtist(
        event.artistId,
      );

      // Cache the songs
      cachedSongs.setSongs(listSongsArtist, event.artistId);

      emit(state.copyWith(
        songsArtistStatus: SongsArtistStatus.loaded,
        songs: listSongsArtist,
      ));
    } catch (e) {
      emit(state.copyWith(songsArtistStatus: SongsArtistStatus.failure));
    }
  }
}
