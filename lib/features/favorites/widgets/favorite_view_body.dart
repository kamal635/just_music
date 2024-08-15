import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/functions/flutter_toast.dart';
import '../../../core/shared_widgets/custom_loading.dart';
import '../../../core/constant/app_strings.dart';
import '../logic/favorite_songs/favorite_songs_bloc.dart';
import 'song_favorite_view.dart';

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
              return SongsFavoriteViewBody(songs: songs ?? []);
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
