import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';

class ButtonMusicTrack extends StatelessWidget {
  const ButtonMusicTrack({super.key, required this.isPlaying});
  final bool? isPlaying;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Previous Button
        CustomIconButton(
            onPressed: () {
              context.read<AudioPlayerBloc>().add(SkipToPreviousAudioEvent());
            },
            icon: AppIcon.skipPrevious),

        // Stop button
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: AppColor.primary,
          ),
          child: IconButton(
            icon: Icon(
              isPlaying! ? AppIcon.pause : AppIcon.play,
              color: AppColor.white,
              size: 22.h,
            ),
            onPressed: () {
              isPlaying!
                  ? context.read<AudioPlayerBloc>().add(PauseAudioEvent())
                  : context.read<AudioPlayerBloc>().add(PlayAudioEvent());
            },
          ),
        ),

        // Next button
        CustomIconButton(
            onPressed: () {
              context.read<AudioPlayerBloc>().add(SkipToNextAudioEvent());
            },
            icon: AppIcon.skipNext),
      ],
    );
  }
}
