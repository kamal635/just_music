import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/home/widgets/music_track/button_music_track.dart';
import 'package:just_music/features/home/widgets/music_track/seek_bar.dart';
import 'package:just_music/features/home/widgets/music_track/title_and_image_music_track.dart';

class MusicTrackPlayer extends StatelessWidget {
  const MusicTrackPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      //Every time the position of the song changes you will build,
      //this is to avoid this from happening
      buildWhen: (previous, current) {
        return (previous.audioPlayerData?.audio !=
                current.audioPlayerData?.audio) ||
            (previous.audioPlayerData?.playbackState !=
                current.audioPlayerData?.playbackState);
      },
      builder: (context, state) {
        ///**********************Short Variables From Bloc***************************/
        ///*************************************************/
        final song = state.audioPlayerData?.audio;
        final isPlaying = state.audioPlayerData?.playbackState.playing;
        final duration = state.audioPlayerData?.audio?.duration;
        final position = state.audioPlayerData?.currentAudioPosition;

        ///*************************************************/
        ///
        // to check if song is playing or not
        if (state.status == AudioPlayerStatus.initial ||
            state.audioPlayerData?.audio == null) {
          return const SizedBox();
        }

        return Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.all(10.r),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ClipRect(
            // Clip the child to avoid unnecessary blurring
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // title and image
                          TitleAndImageMusicTrack(song: song!),

                          // Buttons
                          ButtonMusicTrack(isPlaying: isPlaying),
                        ]),

                    spaceHeight(10),

                    // Slider track
                    SeekBar(duration: duration, position: position),

                    // time songs
                  ],
                )),
          ),
        );
      },
    );
  }
}
