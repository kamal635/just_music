import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/spacer.dart';
import 'custom_elvated_button.dart';
import '../styling/app_colors.dart';
import '../constant/app_icon.dart';
import '../constant/app_strings.dart';
import '../../features/songs/data/model/song.dart';
import '../../features/songs/logic/audio_player/audio_player_bloc.dart';

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
