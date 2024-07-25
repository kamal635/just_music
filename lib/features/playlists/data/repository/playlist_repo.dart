import 'package:hive/hive.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/songs/data/model/song.dart';

abstract class PlaylistRepo {
  //* Open Box
  Future<Box> openBox();

  //* Create Playlist
  Future<void> createPlaylist(Box box, String name);

  //* Remove Playlist
  Future<void> removePlaylist(Box box, String id);

//* Remove Playlist
  Future<void> renamePlaylist(Box box, String name, String id);

  //* Fetch PlayLists
  List<Playlist> fetchPlaylists(Box box);

  //* Add Song To Playlist
  Future<void> addSongToPlaylist(Box box, String playlistId, Song song);

  //* Remove Song From Playlist
  Future<void> removeSongFromPlaylist(Box box, String playlistId, Song song);

  //* Sort Playlists by date added or modified
  List<Playlist> sortByDateCreatedOrModified(Box box);
}

//* REPO ImPLEMETNS
class PlaylistRepoImpl implements PlaylistRepo {
  ///****************Open Box*******************/
  ///******************************************/
  @override
  Future<Box> openBox() async {
    return await Hive.openBox(AppHive.playlist);
  }

  ///*************Create Playlist***************/
  ///******************************************/
  @override
  Future<void> createPlaylist(Box box, String name) async {
    await box.add(Playlist(name: name, songs: const <Song>[]));
  }

  ///*************Remove Playlist***************/
  ///******************************************/
  @override
  Future<void> removePlaylist(Box box, String id) async {
    final key = box.keys.cast<int>().firstWhere((key) {
      final playlist = box.get(key) as Playlist;
      return playlist.id == id;
    });

    await box.delete(key);
  }

  ///*************Rename Playlist***************/
  ///******************************************/
  @override
  Future<void> renamePlaylist(Box box, String name, String id) async {
    final key = box.keys.cast<int>().firstWhere((key) {
      final playlist = box.get(key) as Playlist;
      return playlist.id == id;
    });

    Playlist playlist = box.get(key) as Playlist;
    final updatePlaylist = playlist.copyWith(
      name: name,
      dateCreatedOrModified: DateTime.now(),
    );

    await box.put(key, updatePlaylist);
  }

  ///*************Fetch Playlists***************/
  ///******************************************/
  @override
  List<Playlist> fetchPlaylists(Box box) {
    return box.values.toList().cast<Playlist>();
  }

  ///***********Add Song To Playlist************/
  ///******************************************/
  @override
  Future<void> addSongToPlaylist(Box box, String playlistId, Song song) async {
    // Find the key of the playlist
    final key = box.keys.cast<int>().firstWhere((key) {
      final playlist = box.get(key) as Playlist;
      return playlist.id == playlistId;
    });

    // Retrieve the playlist
    final playlist = box.get(key) as Playlist;

    // Filter out duplicates (ensure song isn't already added)
    final filteredSong = playlist.songs
        ?.where((songInternal) => songInternal.id != song.id)
        .toList();

    // updated song by add song to the songs in playlist
    final updatedSongs = List<Song>.from(filteredSong!.toList())..add(song);

    // updated playlist for added to the box again
    final updatedPlaylist = playlist.copyWith(
      songs: updatedSongs,
      dateCreatedOrModified: DateTime.now(),
      numOfSongs: updatedSongs.length,
    );

    // Put the updated playlist back in the box
    await box.put(key, updatedPlaylist);
  }

  ///***********Remove Song From Playlist************/
  ///******************************************/
  @override
  Future<void> removeSongFromPlaylist(
      Box box, String playlistId, Song song) async {
    // Find the key of the playlist
    final key = box.keys.cast<int>().firstWhere((key) {
      final playlist = box.get(key) as Playlist;
      return playlist.id == playlistId;
    });

    // Retrieve the playlist
    final playlist = box.get(key) as Playlist;

    // updated song by add song to the songs in playlist
    final updatedSongs = List<Song>.from(playlist.songs!.toList())
      ..remove(song);
    // updated playlist for added to the box again
    final updatedPlaylist = playlist.copyWith(
      songs: updatedSongs,
      dateCreatedOrModified: DateTime.now(),
      numOfSongs: updatedSongs.length,
    );

    // Put the updated playlist back in the box
    await box.put(key, updatedPlaylist);
  }

  ///***********Sort By Date Added Or Modified************/
  ///****************************************************/
  @override
  List<Playlist> sortByDateCreatedOrModified(Box box) {
    List<Playlist> playlists = box.values.toList().cast<Playlist>()
      ..sort((a, b) =>
          b.dateCreatedOrModified!.compareTo(a.dateCreatedOrModified!));

    return playlists;
  }
}
