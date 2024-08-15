import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/audio_player/audio_player_bloc.dart';
import '../music_track/seek_bar.dart';

class SeekBarDetilsSong extends StatelessWidget {
  const SeekBarDetilsSong({super.key, this.duration, this.position});
  final Duration? duration;
  final Duration? position;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        return SeekBar(
          position: position,
          duration: duration,
          timeLabelLocation: TimeLabelLocation.below,
          thumbRadius: 5.r,
        );
      },
    );
  }
}
