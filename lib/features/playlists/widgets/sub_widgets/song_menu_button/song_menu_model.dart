import 'package:flutter/material.dart';
import 'abstract_class_actions_song_menu.dart';
import 'actions_classes/add_to_favorite_action.dart';
import 'actions_classes/add_to_playlist_action.dart';
import 'actions_classes/details_song_action.dart';
import 'actions_classes/remove_from_playlist_action.dart';
import '../../../../../core/styling/app_colors.dart';
import '../../../../../core/constant/app_icon.dart';
import '../../../../../core/constant/app_strings.dart';
import '../../../../favorites/data/models/favorite_model.dart';
import '../../../data/model/playlist_model.dart';
import '../../../../songs/data/model/song.dart';

class SongMenuModel {
  final IconData icon;
  final Color colorIcon;
  final String name;
  final SongMenuAction action;

  SongMenuModel({
    required this.icon,
    required this.name,
    required this.action,
    this.colorIcon = AppColor.white,
  });

  static List<SongMenuModel> listSongMenu(
      Song song, FavoriteSong? favoriteSong, Playlist? playlist) {
    final isFavorite =
        favoriteSong?.favoriteSongs.any((fs) => fs.id == song.id) ?? false;

    return [
      // Favorite
      SongMenuModel(
        icon: isFavorite ? AppIcon.favoriteFilled : AppIcon.favoriteBorder,
        colorIcon: isFavorite ? AppColor.favorite : AppColor.white,
        name: AppStrings.addToFavorite,
        action: AddToFavoriteAction(song, isFavorite),
      ),

      // Add To Playlist
      SongMenuModel(
        icon: AppIcon.addMusicOrPlaylist,
        name: AppStrings.addToPlaylist,
        action: AddToPlaylistAction(playlist, song),
      ),

      // Remove From Play List
      SongMenuModel(
        icon: AppIcon.delete,
        name: AppStrings.removeFromPlaylist,
        action: RemoveFromPlaylistAction(song, playlist),
      ),

      // detail
      SongMenuModel(
        icon: AppIcon.detail,
        name: AppStrings.detail,
        action: DetailSongAction(song),
      ),
    ];
  }
}
