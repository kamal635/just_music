import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../functions/flutter_toast.dart';
import 'custom_icon_buttons.dart';
import '../styling/app_colors.dart';
import '../constant/app_icon.dart';
import '../../features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import '../../features/songs/data/model/song.dart';

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

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: CustomIconButton(
            key: ValueKey<bool>(isFavorite),
            onPressed: () async {
              addAndRemoveSongToFavorite(isFavorite, context);
              await toastFavorite(isFavorite: isFavorite, context: context);
            },
            color: changeColorFavorite(isFavorite),
            icon: changeIconFavorite(isFavorite),
          ),
        );
      },
    );
  }

  Color changeColorFavorite(bool isFavorite) =>
      isFavorite ? AppColor.favorite : AppColor.white;

  IconData changeIconFavorite(bool isFavorite) {
    return isFavorite ? AppIcon.favoriteFilled : AppIcon.favoriteBorder;
  }

  void addAndRemoveSongToFavorite(bool isFavorite, BuildContext context) {
    isFavorite
        ? context
            .read<FavoriteSongsBloc>()
            .add(RemoveSongFromFavorite(song: song))
        : context.read<FavoriteSongsBloc>().add(AddSongToFavorite(song: song));
  }
}
