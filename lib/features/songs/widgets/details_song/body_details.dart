import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/shared_widgets/custom_art_work.dart';
import '../../../../core/styling/app_colors.dart';
import '../../logic/audio_player/audio_player_bloc.dart';
import 'control_song_details_song_buttons.dart';
import 'image_title_details_song.dart';
import 'seekbar_details_song.dart';
import 'menu_favorite_add_to_playlist_details_song_buttons.dart';

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
          final songs = state.audioPlayerData?.queue;
          final currentIndex = state.audioPlayerData?.playbackState.queueIndex;
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
                    ImageAndTitleDetailsSong(song: song),

                    spaceHeight(20),

                    // seekbar
                    SeekBarDetilsSong(duration: duration, position: position),

                    spaceHeight(40),

                    // Buttons ( Shuffle + next and previous + play and pause + repeat)
                    ControlSongDetailsSongButtons(
                      isPlaying: isPlaying,
                      currentIndex: currentIndex!,
                      songs: songs!,
                    ),

                    spaceHeight(40),

                    // Buttons ( Menu + Favorite + Add to playlist)
                    MenuAndFavoriteAndAddToPlaylistDetailsSongButtons(
                      song: song,
                    ),

                    spaceHeight(40),
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
