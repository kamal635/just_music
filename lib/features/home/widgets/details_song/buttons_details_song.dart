import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';

import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';

class ButtonsDetailsSong extends StatelessWidget {
  const ButtonsDetailsSong({super.key, required this.isPlaying});
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //* shuffle
        CustomIconButton(
          size: 30.h,
          onPressed: () {},
          icon: AppIcon.shuffle,
          color: AppColor.white.withAlpha(180),
        ),

        //* Skip to Previous
        CustomIconButton(
          size: 30.h,
          onPressed: () {
            context.read<AudioPlayerBloc>().add(SkipToPreviousAudioEvent());
          },
          icon: AppIcon.skipPrevious,
        ),

        //* Play / Pause
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: AppColor.white,
          ),
          child: CustomIconButton(
            size: 30.h,
            onPressed: () {
              isPlaying
                  ? context.read<AudioPlayerBloc>().add(PauseAudioEvent())
                  : context.read<AudioPlayerBloc>().add(PlayAudioEvent());
            },
            icon: isPlaying ? AppIcon.pause : AppIcon.play,
            color: AppColor.black,
          ),
        ),

        //* Skip to Next
        CustomIconButton(
          size: 30.h,
          onPressed: () {
            context.read<AudioPlayerBloc>().add(SkipToNextAudioEvent());
          },
          icon: AppIcon.skipNext,
        ),

        //* Queue Song
        CustomIconButton(
          size: 30.h,
          onPressed: () {},
          icon: AppIcon.musicQueue,
          color: AppColor.white.withAlpha(180),
        ),
      ],
    );
  }
}
