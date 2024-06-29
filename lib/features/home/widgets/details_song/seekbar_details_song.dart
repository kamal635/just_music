import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/home/widgets/music_track/seek_bar.dart';

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
        );
      },
    );
  }
}
