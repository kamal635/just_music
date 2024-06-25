import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/home/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import 'package:just_music/features/home/widgets/card_song.dart';

class ListViewCardSong extends StatelessWidget {
  const ListViewCardSong({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<FetchSongsFromDeviceBloc>()..add(LoadSongsFromDeviceEvent()),
      child: BlocConsumer<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
        listener: (context, state) async {
          if (state.fetchSongsStatus == FetchSongsStatus.failure) {
            await flutterToast(
                message: state.errorMessage ?? AppStrings.unexpectedError);
          }
        },
        builder: (context, state) {
          // when list of songs is Empty
          if (state.songModel?.isEmpty ?? false) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.image2,
                    height: 60.h,
                  ),
                  spaceHeight(10),
                  Text(
                    AppStrings.emptySongs,
                    style: AppFonts.normal_12
                        .copyWith(color: AppColor.white.withAlpha(160)),
                  ),
                ],
              ),
            );
          }

          if (state.fetchSongsStatus == FetchSongsStatus.loading ||
              state.fetchSongsStatus == FetchSongsStatus.initial) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 1.8,
                child: const Center(child: CircularProgressIndicator()));
          }

          if (state.fetchSongsStatus == FetchSongsStatus.loaded) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.songModel!.length,
                itemBuilder: (context, i) {
                  final song = state.songModel![i];
                  return InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () {
                        context.read<AudioPlayerBloc>().add(
                            SetAudioEvent(songs: state.songModel!, index: i));
                      },
                      child: CardSong(song: song, index: i));
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
