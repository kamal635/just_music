import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({super.key, required this.song});
  final Song song;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteSongsBloc, FavoriteSongsState>(
      builder: (context, state) {
        final isFavorite = state.favoriteSong?.favoriteSongs
                .any((songFavorite) => songFavorite.id == song.id) ??
            false;

        return CustomIconButton(
            onPressed: () async {
              addAndRemoveSongToFavorite(isFavorite, context);

              await toastFavorite(isFavorite: isFavorite, context: context);
            },
            color: changeColorFavorite(isFavorite),
            icon: changeIconFavorite(isFavorite));
      },
    );
  }

  // ********** Change Color Favorite
  //******************************/
  Color changeColorFavorite(bool isFavorite) =>
      isFavorite ? AppColor.red : AppColor.white;

  // ********** Change Icon Favorite
  //******************************/
  IconData changeIconFavorite(bool isFavorite) {
    return isFavorite ? AppIcon.favoriteFilled : AppIcon.favoriteBorder;
  }

  // ********** Add And Remove Song
  //******************************/
  void addAndRemoveSongToFavorite(bool isFavorite, BuildContext context) {
    isFavorite
        //* if ture remove
        ? context
            .read<FavoriteSongsBloc>()
            .add(RemoveSongFromFavorite(song: song))

        //* else add
        : context.read<FavoriteSongsBloc>().add(AddSongToFavorite(song: song));
  }
}
