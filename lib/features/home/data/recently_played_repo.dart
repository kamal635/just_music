import 'package:hive/hive.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/songs/data/model/song.dart';

abstract class RecentlyPlayedRepo {
  Future<Box> openBox();
  Future<void> addSong(Box box, Song song);

  List<Song> getSongs(Box box);
}

class RecentlyPlayedRepoImpl implements RecentlyPlayedRepo {
  ///*****************Open Box*********************/
  //////******************************************/
  @override
  Future<Box> openBox() async {
    return Hive.openBox(AppHive.recentlyPlayed);
  }

  ///*****************Add Song*********************/
  //////******************************************/
  @override
  Future<void> addSong(Box box, Song song) async {
    // Fetch the current list of songs
    final updatedList = box.values.toList().cast<Song>();

    // Remove the current song if it already exists
    updatedList.removeWhere((s) => s.id == song.id);

    // Insert the new song at the beginning of the list
    updatedList.insert(0, song);

    // Ensure the list contains no more than 10 items
    while (updatedList.length > 10) {
      updatedList.removeLast();
    }
    // Clear the box and add the updated list back
    await box.clear();
    await box.addAll(updatedList);
  }

  ///*****************Get Songs*******************/
  //////*****************************************/
  @override
  List<Song> getSongs(Box box) {
    final listRecentlyPlayed = box.values.toList().cast<Song>();

    // Return only the top 10 items
    return listRecentlyPlayed.take(10).toList();
  }
}
