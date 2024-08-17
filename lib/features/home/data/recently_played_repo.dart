import 'dart:io';

import 'package:hive/hive.dart';
import '../../../core/constant/app_strings.dart';
import '../../songs/data/model/song.dart';

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
    // Fetch the current list of songs
    final listRecentlyPlayed = box.values.toList().cast<Song>();

    // Filter the list to remove songs whose file path doesn't exist
    final filteredList = listRecentlyPlayed.where((song) {
      final file = File(song.audioUrl!);
      return file.existsSync(); // Keep only the songs whose file exists
    }).toList();

    // If there are any changes (songs removed), update the Hive box
    if (filteredList.length != listRecentlyPlayed.length) {
      box.clear(); // Clear the existing entries
      box.addAll(filteredList); // Add back the filtered list
    }

    // Return only the top 10 items
    return filteredList.take(10).toList();
  }
}
