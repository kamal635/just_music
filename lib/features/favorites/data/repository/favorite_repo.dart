import 'package:hive/hive.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/songs/data/model/song.dart';

abstract class FavoriteRepo {
  Future<Box> openBox();
  Future<void> addSongToFavorite(Box box, Song song);
  Future<void> removeSongFromFavorite(Box box, Song song);
  List<Song> getSongs(Box box);
}

class FavoriteRepoImpl implements FavoriteRepo {
  @override
  Future<Box> openBox() async {
    return await Hive.openBox(AppHive.favoriteBox);
  }

  @override
  Future<void> addSongToFavorite(Box box, Song song) async {
    await box.put(song.id, song);
  }

  @override
  Future<void> removeSongFromFavorite(Box box, Song song) async {
    await box.delete(song.id);
  }

  @override
  List<Song> getSongs(Box box) {
    return box.values.toList().cast<Song>();
  }
}
