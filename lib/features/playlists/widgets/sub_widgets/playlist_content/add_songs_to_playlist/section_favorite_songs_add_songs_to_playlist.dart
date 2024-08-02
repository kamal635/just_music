import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/card_add_songs_to_playlist.dart';

class SectionFavoriteSongsAddSongsToPlaylist extends StatelessWidget {
  const SectionFavoriteSongsAddSongsToPlaylist(
      {super.key, required this.playlistComeFromPreviousPage});
  final Playlist playlistComeFromPreviousPage;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteSongsBloc, FavoriteSongsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.pushNamed(
                RouterName.listOfSongsFavoriteToAddToAddToPlaylist,
                arguments: {
                  AppArguments.favoriteSong: state.favoriteSong,
                  AppArguments.playlistComeFromPreviousPage:
                      playlistComeFromPreviousPage,
                });
          },
          child: CustomCardAddSongToPlaylist(
            icon: AppIcon.favoriteFilled,
            colorCard: AppColor.favorite.withAlpha(110),
            colorIcon: AppColor.favorite,
            title: AppStrings.favoriteSongs,
            isTrailing: true,
            subtitle: state.favoriteSong?.favoriteSongs.length ?? 0,
          ),
        );
      },
    );
  }
}
