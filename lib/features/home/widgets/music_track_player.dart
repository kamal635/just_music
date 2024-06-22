import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicTrackPlayer extends StatelessWidget {
  const MusicTrackPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      //Every time the position of the song changes you will build,
      //this is to avoid this from happening
      buildWhen: (previous, current) {
        return previous.audioPlayerData?.audio !=
            current.audioPlayerData?.audio;
      },
      builder: (context, state) {
        final song = state.audioPlayerData?.audio;
        final duration =
            state.audioPlayerData?.audio!.duration!.inMilliseconds.toDouble();
        final position = state
            .audioPlayerData?.currentAudioPosition!.inMilliseconds
            .toDouble();
        // to check if song is playing or not
        if (state.status == AudioPlayerStatus.initial ||
            state.audioPlayerData?.audio == null) {
          return const SizedBox();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              color: AppColor.primary,
              height: kToolbarHeight + 5.h,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // image

                      QueryArtworkWidget(
                        keepOldArtwork: true,
                        id: song!.id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: Image.asset(AppImages.image1),
                        ),
                      ),

                      spaceWidth(10),

                      // Title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            song.title,
                            style: AppFonts.medium_12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            song.artist ?? AppStrings.unknown,
                            style: AppFonts.normal_8
                                .copyWith(color: AppColor.white.withAlpha(140)),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Buttons
                  Row(
                    children: [
                      // Previous Button
                      CustomIconButton(
                          onPressed: () {}, icon: AppIcon.skipPrevious),

                      // Stop button
                      IconButton.filled(
                        icon: Icon(
                          AppIcon.play,
                          color: AppColor.white,
                          size: 22.h,
                        ),
                        onPressed: () {},
                        // style: IconButton.styleFrom(
                        //     backgroundColor: AppColor.w),
                      ),

                      // Next button
                      CustomIconButton(
                          onPressed: () {}, icon: AppIcon.skipNext),
                    ],
                  ),
                ],
              ),
            ),

            // Slider truck
            SizedBox(
              height: 4.h,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: SliderComponentShape.noThumb,
                  overlayShape: SliderComponentShape.noOverlay,
                  // activeTrackColor: AppColor.orange,
                  inactiveTrackColor: AppColor.white.withAlpha(140),
                ),
                child: Slider(
                  min: 0,
                  max: duration!,
                  value: min(duration, position!),
                  onChanged: (onChanged) {},
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
