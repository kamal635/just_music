import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/duration.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';

class TimeSongs extends StatelessWidget {
  const TimeSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        final song = state.audioPlayerData?.audio;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// ********
              /// Position Song
              song!.duration! > const Duration(milliseconds: 3600000)
                  ? Text(
                      "${state.audioPlayerData?.currentAudioPosition!.toFormattedStringWithHoursWithoutCharacter()}")
                  : Text(
                      "${state.audioPlayerData?.currentAudioPosition!.toFormattedStringWithoutHoursWithoutCharacter()}"),

              /// ********
              /// Duration Song
              song.duration! > const Duration(milliseconds: 3600000)
                  ? Text(
                      "${state.audioPlayerData?.audio?.duration!.toFormattedStringWithHoursWithoutCharacter()}")
                  : Text(
                      "${state.audioPlayerData?.audio?.duration!.toFormattedStringWithoutHoursWithoutCharacter()}"),
            ],
          ),
        );
      },
    );
  }
}
