import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';

import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';

class ButtonsDetailsSong extends StatelessWidget {
  const ButtonsDetailsSong({
    super.key,
    required this.isPlaying,
  });
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //************** Shuffle Button ******************/
        //***********************************************/
        BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, state) {
            //** Short Variable */
            final shuffleMode =
                state.audioPlayerData?.playbackState.shuffleMode;
            final shuffleModeEnabled =
                shuffleMode == AudioServiceShuffleMode.all;

            //** Button */
            return CustomIconButton(
              size: 30.h,
              onPressed: () async {
                final enabled = !shuffleModeEnabled;

                //***Excute Event Shuffle Mode**/
                context.read<AudioPlayerBloc>().add(ShuffleModeAudioEvent(
                    shuffleMode: enabled
                        ? AudioServiceShuffleMode.all
                        : AudioServiceShuffleMode.none));

                //*** Toast Shuffle Mode */
                await toastShuffleMode(enabled);
              },
              icon: AppIcon.shuffle,
              color: shuffleModeEnabled
                  ? AppColor.white
                  : AppColor.white.withAlpha(120),
            );
          },
        ),

        //************** Skip to Previous ******************/
        //*************************************************/
        CustomIconButton(
          size: 30.h,
          onPressed: () {
            context.read<AudioPlayerBloc>().add(SkipToPreviousAudioEvent());
          },
          icon: AppIcon.skipPrevious,
          color: AppColor.white,
        ),

        //**************** Play / Pause ********************/
        //*************************************************/
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

        //**************** Skip to Next ********************/
        //*************************************************/
        CustomIconButton(
          size: 30.h,
          onPressed: () {
            context.read<AudioPlayerBloc>().add(SkipToNextAudioEvent());
          },
          icon: AppIcon.skipNext,
        ),

        //**************** Repeat Mode *********************/
        //*************************************************/
        BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, state) {
            //** Short Variable */
            final repeatMode = state.audioPlayerData?.playbackState.repeatMode;
            final repeateAll = repeatMode == AudioServiceRepeatMode.all;
            final repeateOne = repeatMode == AudioServiceRepeatMode.one;
            return CustomIconButton(
              size: 30.h,
              onPressed: () {
                //***Excute Event Repeate Mode**/
                excuteEventRepeatMode(context, repeatMode);

                //*** Toast Repeat Mode */
                toastRepeatMode(repeateAll, repeateOne);
              },
              icon: repeateAll
                  ? AppIcon.repateOff
                  : repeateOne
                      ? AppIcon.repateOne
                      : AppIcon.repateOff,
              color: repeateAll || repeateOne
                  ? AppColor.white
                  : AppColor.white.withAlpha(180),
            );
          },
        ),
      ],
    );
  }

  void excuteEventRepeatMode(
      BuildContext context, AudioServiceRepeatMode? repeatMode) {
    //***Excute Event Repeate Mode**/
    context.read<AudioPlayerBloc>().add(RepeatModeAudioEvent(
            repeateMode: switch (repeatMode) {
          //*** initial none : when I press it become (one)*/
          AudioServiceRepeatMode.none => AudioServiceRepeatMode.one,
          //*** if was (one) when I press it become (all)*/
          AudioServiceRepeatMode.one => AudioServiceRepeatMode.all,
          //*** if was (all) when I press it become (none)*/
          AudioServiceRepeatMode.all => AudioServiceRepeatMode.none,
          //*** disable*/
          AudioServiceRepeatMode.group => throw UnimplementedError(),
          //*** if was null retrun initial (none)*/
          null => AudioServiceRepeatMode.none,
        }));
  }
}
