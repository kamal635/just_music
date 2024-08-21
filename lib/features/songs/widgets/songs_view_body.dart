import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import '../../../core/functions/flutter_toast.dart';
import '../../../core/shared_widgets/custom_loading.dart';
import 'list_view_songs.dart';
import '../logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import '../../../core/shared_widgets/image_empty_list.dart';
import '../../../core/constant/app_images.dart';
import '../../../core/constant/app_strings.dart';

class SongsViewBody extends StatelessWidget {
  const SongsViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
      listener: (context, state) async {
        if (state.fetchSongsStatus == FetchSongsStatus.failure) {
          await flutterToastSuccessfully(
            context: context,
            message: state.errorMessage ?? AppStrings.unexpectedError,
          );
        }
      },
      builder: (context, state) {
        if (state.fetchSongsStatus == FetchSongsStatus.loading) {
          return const CustomLoading();
        }

        if (state.songs.isEmpty) {
          return const ImageEmptyList(image: AppImages.emptySongs);
        }

        return Padding(
          padding: EdgeInsets.only(left: 12.r),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  sliverPadding(15),

                  // songs
                  CustomSliverListSongs(
                    songs: state.songs,
                    hideIndex: 2,
                  ),

                  sliverPadding(80),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
