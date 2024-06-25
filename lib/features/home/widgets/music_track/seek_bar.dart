import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';

class SeekBar extends StatelessWidget {
  const SeekBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        final duration =
            state.audioPlayerData?.audio?.duration!.inMilliseconds.toDouble();
        final position = state
            .audioPlayerData?.currentAudioPosition!.inMilliseconds
            .toDouble();
        return Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  // thumbShape: SliderComponentShape.noThumb,
                  overlayShape: SliderComponentShape.noOverlay,
                  // activeTrackColor: AppColor.orange,
                  inactiveTrackColor: AppColor.white.withAlpha(140),
                ),
                child: Slider(
                  min: 0,
                  max: duration!,
                  value: min(duration, position!),
                  onChanged: (value) {
                    context.read<AudioPlayerBloc>().add(
                        SeekToPositionAudioEvent(
                            position: Duration(milliseconds: value.toInt())));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
