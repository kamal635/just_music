import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/list_view_songs.dart';
import 'package:just_music/features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import 'package:just_music/features/songs/widgets/search/section_search.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';

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
          return const Center(child: CircularProgressIndicator());
        }
        //* Loaded
        if (loaded) {
          // when list of songs is Empty
          if (songs == null || songs.isEmpty) {
            return const ImageEmptyList(image: AppImages.image2);
          }

          // when fetch song success
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // padding
                sliverPadding(15),

                // Search box
                const SliverToBoxAdapter(
                  child: SectionSearch(),
                ),

                // padding
                sliverPadding(15),

                // List Songs
                CustomSliverListSongs(songs: songs),

                // padding
                sliverPadding(kTextTabBarHeight + 80.h),
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
