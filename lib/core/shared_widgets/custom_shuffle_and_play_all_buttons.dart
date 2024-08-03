import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';

class CustomShuffleAndPlayAllButtons extends StatelessWidget {
  const CustomShuffleAndPlayAllButtons({super.key, required this.songs});
  final List<Song>? songs;
  @override
  Widget build(BuildContext context) {
    return //* Buttons
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Suffle Button
        Expanded(
          child: CustomElevatedButton(
            onPressed: () {
              songs == null || songs!.isEmpty
                  ? null
                  : context
                      .read<AudioPlayerBloc>()
                      .add(SetAudioEvent(songs: songs ?? [], index: 0));

              context.read<AudioPlayerBloc>().add(const ShuffleModeAudioEvent(
                  shuffleMode: AudioServiceShuffleMode.all));
            },
            titleWithIcon: AppStrings.shuffle,
            isIcon: true,
            icon: AppIcon.shuffle,
            sizeIcon: 16.h,
          ),
        ),

        spaceWidth(20),

        // Play Button
        Expanded(
          child: CustomElevatedButton(
            onPressed: () {
              songs == null || songs!.isEmpty
                  ? null
                  : context
                      .read<AudioPlayerBloc>()
                      .add(SetAudioEvent(songs: songs ?? [], index: 0));

              context.read<AudioPlayerBloc>().add(const ShuffleModeAudioEvent(
                  shuffleMode: AudioServiceShuffleMode.none));
            },
            titleWithIcon: AppStrings.playAll,
            isIcon: true,
            icon: AppIcon.play,
            colorButton: Colors.transparent,
            colorBorderSide: AppColor.white,
          ),
        )
      ],
    );
  }
}
