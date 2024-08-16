import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/helpers/navigation.dart';
import '../../../../../../core/routes/string_route.dart';
import '../../../../../../core/styling/app_colors.dart';
import '../../../../../../core/constant/app_icon.dart';
import '../../../../../../core/constant/app_strings.dart';
import '../../../../../favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import '../../../../data/model/playlist_model.dart';
import 'card_add_songs_to_playlist.dart';

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
            context.pushNamed(RouterName.listOfSongsFavoriteToAddToPlaylist,
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
