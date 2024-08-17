import 'dart:io';

import 'package:hive/hive.dart';
import '../../../core/constant/app_strings.dart';
import '../models/most_played_model.dart';

abstract class MostPlayedRepo {
  Future<Box> openBox();
  Future<void> addSong(Box box, MostPlayedModel mostPlayed);

  List<MostPlayedModel> getSongs(Box box);
}

class MostPlayedRepoImpl implements MostPlayedRepo {
  ///*****************Open Box*********************/
  //////******************************************/
  @override
  Future<Box> openBox() async {
    return Hive.openBox(AppHive.mostPlayed);
  }

  ///*****************Add Song*********************/
  //////******************************************/
  @override
  Future<void> addSong(Box box, MostPlayedModel mostPlayed) async {
    // Fetch the current list of songs
    final updatedList = box.values.toList().cast<MostPlayedModel>();

    // Find the current song if it already exists
    final existingSongIndex = updatedList.indexWhere(
      (msp) => msp.song.id == mostPlayed.song.id,
    );

    if (existingSongIndex != -1) {
      // Increment play count for the existing song
      final existingSong = updatedList[existingSongIndex];
      final updatedMostPlayed = existingSong.copyWith(
        playCount: existingSong.playCount + 1,
      );

      // Replace the existing entry with the updated one
      updatedList[existingSongIndex] = updatedMostPlayed;
    } else {
      // Set play count for the new song
      final newMostPlayed = mostPlayed.copyWith(
        playCount: 1,
      );

      // Add the new song to the list
      updatedList.add(newMostPlayed);
    }

    // Sort the list by play count in descending order
    updatedList.sort((a, b) => b.playCount.compareTo(a.playCount));

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
  List<MostPlayedModel> getSongs(Box box) {
    // Fetch the current list of songs
    final listMostPlayed = box.values.toList().cast<MostPlayedModel>();

    // Filter the list to remove songs whose file path doesn't exist
    final filteredList = listMostPlayed.where((msp) {
      final file = File(msp.song.audioUrl!);
      return file.existsSync(); // Keep only the songs whose file exists
    }).toList();

    // If there are any changes (songs removed), update the Hive box
    if (filteredList.length != listMostPlayed.length) {
      box.clear(); // Clear the existing entries
      box.addAll(filteredList); // Add back the filtered list
    }

    // Ensure the list is sorted by play count in descending order
    filteredList.sort((a, b) => b.playCount.compareTo(a.playCount));

    // Return only the top 10 items
    return filteredList.take(10).toList();
  }
}
