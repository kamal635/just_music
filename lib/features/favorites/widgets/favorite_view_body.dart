import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/shared_widgets/list_view_songs.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.r),
        child: BlocConsumer<FavoriteSongsBloc, FavoriteSongsState>(
          listener: (context, state) async {
            //*** state Failure */
            if (state.favoriteSongsStatus == FavoriteSongsStatus.failure) {
              await flutterToast(
                  message: state.errorMessage ?? "Unknown error..!");
            }
          },
          builder: (context, state) {
            final songs = state.favoriteSong?.favoriteSongs;

            //*** state Loading */
            if (state.favoriteSongsStatus == FavoriteSongsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            //**** state loaded */
            if (state.favoriteSongsStatus == FavoriteSongsStatus.loaded) {
              //*** List of favorite song (empty || null) */
              if (songs == null || songs.isEmpty) {
                return const ImageEmptyList(image: AppImages.image2);
              }

              //*** if song is loaded success */
              return ListViewBuilderSongs(
                songs: songs,
                isFavorite: true,
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
