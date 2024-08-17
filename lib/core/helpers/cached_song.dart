import 'package:just_music/features/songs/data/model/song.dart';

class CachedSongs {
  final Map<int, List<Song>> _cachedSongs = {};

  void setSongs(List<Song> songs, int id) {
    _cachedSongs[id] = songs;
  }

  List<Song> getSongs(int id) {
    return _cachedSongs[id] ?? [];
  }
}
