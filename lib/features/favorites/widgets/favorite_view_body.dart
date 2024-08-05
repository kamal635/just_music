import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/favorites/widgets/song_favorite_view.dart';

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
              await flutterToastSuccessfully(
                  context: context,
                  message: state.errorMessage ?? AppStrings.unexpectedError);
            }
          },
          builder: (context, state) {
            final songs = state.favoriteSong?.favoriteSongs;

            //*** state Loading */
            if (state.favoriteSongsStatus == FavoriteSongsStatus.loading) {
              return const CustomLoading();
            }

            //**** state loaded */
            if (state.favoriteSongsStatus == FavoriteSongsStatus.loaded) {
              return SongsFavoriteViewBody(songs: songs!);
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
