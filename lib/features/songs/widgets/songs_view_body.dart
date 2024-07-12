import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/shared_widgets/list_view_songs.dart';
import 'package:just_music/features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import 'package:just_music/features/songs/widgets/section_text_form_field.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';

class SongsViewBody extends StatelessWidget {
  const SongsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
      //* Listen
      listener: (context, state) async {
        if (state.fetchSongsStatus == FetchSongsStatus.failure) {
          await flutterToast(
              context: context,
              message: state.errorMessage ?? AppStrings.unexpectedError);
        }
      },

      //* Builder
      builder: (context, state) {
        final songs = state.songs;

        if (state.fetchSongsStatus == FetchSongsStatus.loading ||
            state.fetchSongsStatus == FetchSongsStatus.initial) {
          //* Loading
          return SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: const Center(child: CircularProgressIndicator()));
        }
        if (state.fetchSongsStatus == FetchSongsStatus.loaded) {
          //* when list of songs is Empty
          if (songs == null || songs.isEmpty) {
            return const ImageEmptyList(image: AppImages.image2);
          }
          //* when fetch song success
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(14.r),
                        child: const SectionTextFormField()),
                  ],
                ),
              ),
              SliverListSongs(songs: songs),

              //* this to add padding in the bottom CustomScrollView
              SliverPadding(
                padding: EdgeInsets.only(
                    bottom: kTextTabBarHeight +
                        80.h), // Adjust the padding as needed
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
