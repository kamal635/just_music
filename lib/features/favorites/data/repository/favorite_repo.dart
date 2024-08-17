import 'dart:io';

import 'package:hive/hive.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../songs/data/model/song.dart';

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
    // Fetch the current list of songs
    final favoriteSongs = box.values.toList().cast<Song>();

    // Filter the list to remove songs whose file path doesn't exist
    final filteredList = favoriteSongs.where((song) {
      final file = File(song.audioUrl!);
      return file.existsSync(); // Keep only the songs whose file exists
    }).toList();

    // If there are any changes (songs removed), update the Hive box
    if (filteredList.length != favoriteSongs.length) {
      box.clear(); // Clear the existing entries
      box.addAll(filteredList); // Add back the filtered list
    }

    // Return only the top 10 items
    return filteredList.toList();
  }
}
