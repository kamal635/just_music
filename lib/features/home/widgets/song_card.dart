import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/duration.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/shared_widgets/favorite_icon_button.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';

class SongCard extends StatefulWidget {
  const SongCard({
    super.key,
    required this.song,
    this.isFavorite = false,
  });

  final Song song;

  final bool isFavorite;

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  //** This ValueNotifier is used to store the state of the audio player
  //** and whether the current song is being played or not
  final _valueNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    listenStateAudioPlayer();
    super.initState();
  }

  //** Listen to the AudioPlayerBloc stream to update the _valueNotifier
  //** whenever the audio player state changes
  void listenStateAudioPlayer() {
    context.read<AudioPlayerBloc>().stream.listen((state) {
      final id = state.audioPlayerData?.audio?.id;
      if (id != null && id == widget.song.id) {
        _valueNotifier.value = true;
      } else {
        _valueNotifier.value = false;
      }
    });
  }

  ///*********/
  /// [ValueListenableBuilder] was usedTo listen to the change in the playing status of the song
  /// and apply to change the background color of the song when it is played
  /// When using BlocBuilder it led to many construction operations,
  /// which led to a significant slowdown in the application when playing the song,
  /// and scrolling within the application became not smooth.
  ///*******/
  @override
  Widget build(BuildContext context) {
    //** Use the ValueListenableBuilder to update the UI based on the
    //** value of the _valueNotifier
    return ValueListenableBuilder(
      valueListenable: _valueNotifier,
      builder: (context, valueNotifier, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: valueNotifier ? AppColor.secondary : null,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: child,
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,

        //** leading ( image )
        leading: SizedBox(
          child: CustomArtWork(id: widget.song.id),
        ),

        //** trailing ( Duration Song )
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.song.duration! > const Duration(milliseconds: 3600000)
                  ? widget.song.duration!
                      .toFormattedStringWithHoursWithCharacter()
                  : widget.song.duration!
                      .toFormattedStringWithoutHoursWithCharacter(),
              style: AppFonts.normal_10
                  .copyWith(color: AppColor.white.withAlpha(120)),
            ),

            //** Favorite Icon */
            widget.isFavorite
                ? FavoriteIconButton(song: widget.song)
                : const SizedBox(),
          ],
        ),

        //** title
        title: Text(
          widget.song.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        titleTextStyle: AppFonts.medium_14,

        //** subtitle
        subtitle: Text(
          widget.song.artist ?? AppStrings.unknown,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitleTextStyle:
            AppFonts.normal_10.copyWith(color: AppColor.white.withAlpha(120)),
      ),
    );
  }
}
