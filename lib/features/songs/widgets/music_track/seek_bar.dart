import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/styling/app_fonts.dart';

import '../../logic/audio_player/audio_player_bloc.dart';

class SeekBar extends StatelessWidget {
  const SeekBar(
      {super.key,
      required this.position,
      required this.duration,
      this.timeLabelLocation,
      this.thumbRadius});
  final Duration? position;
  final Duration? duration;
  final TimeLabelLocation? timeLabelLocation;
  final double? thumbRadius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: ProgressBar(
        // Set the progress to the current position or zero if null
        progress: position ?? Duration.zero,
        // Set the total duration of the song
        total: duration ?? Duration.zero,
        // Callback for seeking when the user interacts with the progress bar
        onSeek: (position) {
          context
              .read<AudioPlayerBloc>()
              .add(SeekToPositionAudioEvent(position: position));
        },
        // Customize the appearance of the progress bar
        barHeight: 3,
        thumbRadius: thumbRadius ?? 0,
        timeLabelLocation: timeLabelLocation ?? TimeLabelLocation.none,
        timeLabelTextStyle: AppFonts.normal_12,
        timeLabelPadding: 12,
        baseBarColor: AppColor.white.withAlpha(55),
        thumbGlowColor: AppColor.white.withAlpha(55),
        thumbColor: AppColor.lightBlue,
        progressBarColor: AppColor.lightBlue,
      ),
    );
  }
}
