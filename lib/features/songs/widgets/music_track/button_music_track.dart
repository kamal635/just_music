import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';

class ButtonMusicTrack extends StatelessWidget {
  const ButtonMusicTrack(
      {super.key,
      required this.isPlaying,
      required this.songs,
      required this.currentIndex});
  final bool? isPlaying;
  final List<Song> songs;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // pause/play button
        IconButton(
          icon: Icon(
            isPlaying! ? AppIcon.pause : AppIcon.play,
            color: AppColor.white,
            size: 26.h,
          ),
          onPressed: () {
            isPlaying!
                ? context.read<AudioPlayerBloc>().add(PauseAudioEvent())
                : context.read<AudioPlayerBloc>().add(PlayAudioEvent());
          },
        ),

        // Next button
        CustomIconButton(
          onPressed: currentIndex < songs.length - 1
              ? () {
                  context.read<AudioPlayerBloc>().add(SkipToNextAudioEvent());
                }
              : null,
          icon: AppIcon.skipNext,
          color: currentIndex < songs.length - 1
              ? AppColor.white
              : AppColor.white.withAlpha(110),
          size: 26.h,
        ),
      ],
    );
  }
}
