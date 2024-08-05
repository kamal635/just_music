import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/details_song/body_details.dart';
import 'package:just_music/features/songs/widgets/music_track/button_music_track.dart';
import 'package:just_music/features/songs/widgets/music_track/seek_bar.dart';
import 'package:just_music/features/songs/widgets/music_track/title_and_image_music_track.dart';

class MusicTrackPlayer extends StatelessWidget {
  const MusicTrackPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        ///**************Short Variables From Bloc************/
        ///*************************************************/
        final song = state.audioPlayerData?.audio;
        final songs = state.audioPlayerData?.queue;
        final currentIndex = state.audioPlayerData?.playbackState.queueIndex;
        final isPlaying = state.audioPlayerData?.playbackState.playing;
        final duration = state.audioPlayerData?.audio?.duration;
        final position = state.audioPlayerData?.currentAudioPosition;

        ///*************************************************/

        // to check if song is playing or not
        if (state.status == AudioPlayerStatus.initial ||
            state.audioPlayerData?.audio == null) {
          return const SizedBox();
        }

        return InkWell(
          onTap: () async {
            await detailsSong(context: context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.r),
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                    color: AppColor.navBottomBar,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // title and image
                      TitleAndImageMusicTrack(song: song!),

                      // Buttons
                      ButtonMusicTrack(
                        isPlaying: isPlaying,
                        songs: songs!,
                        currentIndex: currentIndex!,
                      ),
                    ]),
              ),
              // Slider track
              SeekBar(duration: duration, position: position),
            ],
          ),
        );
      },
    );
  }
}
