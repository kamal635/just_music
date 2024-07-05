import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
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
      return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          final song = state.audioPlayerData!.audio;
          final duration = state.audioPlayerData?.audio?.duration;
          final position = state.audioPlayerData?.currentAudioPosition;
          final isPlaying = state.audioPlayerData!.playbackState.playing;

          return Stack(
            fit: StackFit.expand,
            children: [
              CustomArtWork(
                id: song!.id,
              ),
              ClipRRect(
                  // Clip it cleanly.
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        color: AppColor.primary.withOpacity(0.5),
                        alignment: Alignment.center,
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
              )
            ],
          );
        },
      );
    },
  );
}
