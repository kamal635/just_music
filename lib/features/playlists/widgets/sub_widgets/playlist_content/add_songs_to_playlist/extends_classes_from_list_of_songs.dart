import '../../../../../../core/constant/app_strings.dart';
import '../../../../../favorites/data/models/favorite_model.dart';
import '../../../../data/model/playlist_model.dart';
import 'list_of_songs_to_add_to_playlist.dart';
import '../../../../../songs/data/model/song.dart';

//* Specific class for favorite songs
class SongsFavoriteToAddToPlaylist extends ListOfSongs {
  SongsFavoriteToAddToPlaylist({
    super.key,
    required FavoriteSong favoriteSong,
    required Playlist playlist,
    required Playlist playlistComeFromPreviousPage,
  }) : super(
          title: AppStrings.favoriteSongs,
          songs: favoriteSong.favoriteSongs,
          playlist: playlistComeFromPreviousPage,
          playlistComeFromPreviousPage: playlistComeFromPreviousPage,
        );
}

//* Specific class for local songs
class SongsLocalToAddToPlaylist extends ListOfSongs {
  const SongsLocalToAddToPlaylist({
    super.key,
    required List<Song> songs,
    required Playlist playlist,
    required Playlist playlistComeFromPreviousPage,
  }) : super(
          title: AppStrings.localSongs,
          songs: songs,
          playlist: playlistComeFromPreviousPage,
          playlistComeFromPreviousPage: playlistComeFromPreviousPage,
        );
}

//* Specific class for playlist songs
class SongsPlaylistToAddToPlaylist extends ListOfSongs {
  SongsPlaylistToAddToPlaylist({
    super.key,
    required Playlist playlist,
    required Playlist playlistComeFromPreviousPage,
  }) : super(
          playlist: playlist,
          title: playlist.name,
          songs: playlist.songs!,
          playlistComeFromPreviousPage: playlistComeFromPreviousPage,
        );
}
