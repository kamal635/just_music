import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/duration.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CardSong extends StatelessWidget {
  const CardSong({super.key, required this.song, required this.index});

  final Song song;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: state.audioPlayerData!.playbackState.queueIndex == index &&
                    state.audioPlayerData!.playbackState.playing
                ? AppColor.white.withAlpha(60)
                : null,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,

            // leading ( image )
            leading: QueryArtworkWidget(
              id: song.id,
              type: ArtworkType.AUDIO,
              keepOldArtwork: true,
              nullArtworkWidget: ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: Image.asset(AppImages.image1),
              ),
            ),

            // trailing ( icon )
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  song.duration! > const Duration(milliseconds: 3600000)
                      ? song.duration!.toFormattedStringWithHoursWithCharacter()
                      : song.duration!
                          .toFormattedStringWithoutHoursWithCharacter(),
                  style: AppFonts.normal_10
                      .copyWith(color: AppColor.white.withAlpha(120)),
                ),
              ],
            ),

            // title
            title: Text(
              song.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            titleTextStyle: AppFonts.medium_14,

            // subtitle
            subtitle: Text(
              song.artist ?? AppStrings.unknown,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitleTextStyle: AppFonts.normal_10
                .copyWith(color: AppColor.white.withAlpha(120)),
          ),
        );
      },
    );
  }
}
