import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/home/widgets/details_song/buttons_details_song.dart';
import 'package:just_music/features/home/widgets/details_song/image_details_song.dart';
import 'package:just_music/features/home/widgets/details_song/seekbar_details_song.dart';
import 'package:just_music/features/home/widgets/details_song/title_favorite_details_song.dart';

Future<void> detailsSong({
  required BuildContext context,
}) async {
  return await showModalBottomSheet(
    // to take showModalBottomSheet full height
    isScrollControlled: true,

    // The color that appears behind the BottomSheet when you want to close it by dragging it down
    barrierColor: AppColor.primary,

    // color showModalBottomSheet
    backgroundColor: AppColor.primary,

    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, state) {
            final song = state.audioPlayerData!.audio;
            final duration = state.audioPlayerData?.audio?.duration;
            final position = state.audioPlayerData?.currentAudioPosition;
            final isPlaying = state.audioPlayerData!.playbackState.playing;
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // image
                ImageDetailsSong(song: song),

                spaceHeight(20),

                // section controller in song
                TitleAndFavoriteDetailsSong(song: song),

                spaceHeight(40),

                // seekbar
                SeekBarDetilsSong(duration: duration, position: position),

                spaceHeight(40),

                // buttons
                ButtonsDetailsSong(
                  isPlaying: isPlaying,
                ),

                spaceHeight(80),
              ],
            );
          },
        ),
      );
    },
  );
}
