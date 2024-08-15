import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/functions/flutter_toast.dart';
import '../../../core/helpers/spacer.dart';
import '../../../core/shared_widgets/custom_loading.dart';
import '../../../core/shared_widgets/list_view_songs.dart';
import '../logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import '../../../core/shared_widgets/image_empty_list.dart';
import '../../../core/constant/app_images.dart';
import '../../../core/constant/app_strings.dart';

class SongsViewBody extends StatelessWidget {
  const SongsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
      //**** Listener ***
      listener: (context, state) async {
        final failure = state.fetchSongsStatus == FetchSongsStatus.failure;

        //* Failure
        if (failure) {
          await flutterToastSuccessfully(
              context: context,
              message: state.errorMessage ?? AppStrings.unexpectedError);
        }
      },

      //**** Builder ***
      builder: (context, state) {
        final songs = state.songs;
        final loading = state.fetchSongsStatus == FetchSongsStatus.loading;
        final initial = state.fetchSongsStatus == FetchSongsStatus.initial;
        final loaded = state.fetchSongsStatus == FetchSongsStatus.loaded;

        //* Loading
        if (loading || initial) {
          return const CustomLoading();
        }
        //* Loaded
        if (loaded) {
          // when list of songs is Empty
          if (songs.isEmpty) {
            return const ImageEmptyList(image: AppImages.emptySongs);
          }

          // when fetch song success
          return Padding(
            padding: EdgeInsets.only(left: 12.r),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // padding
                sliverPadding(15),

                // List Songs
                CustomSliverListSongs(
                  songs: songs,
                  hideIndex: 2,
                ),

                // padding
                sliverPadding(60),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
