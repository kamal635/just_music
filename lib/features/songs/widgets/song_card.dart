import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/duration.dart';
import '../../../core/helpers/spacer.dart';
import '../../../core/shared_widgets/custom_art_work.dart';
import '../../../core/shared_widgets/favorite_icon_button.dart';
import '../../../core/styling/app_fonts.dart';
import '../../../core/styling/app_colors.dart';
import '../../../core/constant/app_images.dart';
import '../../../core/constant/app_strings.dart';
import '../../playlists/widgets/sub_widgets/song_menu_button/song_menu_button.dart';
import '../data/model/song.dart';
import '../logic/audio_player/audio_player_bloc.dart';

class SongCard extends StatefulWidget {
  const SongCard({
    super.key,
    required this.song,
    this.isFavorite = false,
    this.hideIndex,
  });

  final Song song;

  final bool isFavorite;
  final int? hideIndex;

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
          decoration: BoxDecoration(
            // color: valueNotifier ? AppColor.secondary : null,
            borderRadius: BorderRadius.circular(10.r),
          ),
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
                valueNotifier
                    ? Image.asset(
                        AppImages.waveSoundAnimated,
                        height: 20.h,
                      )
                    : const SizedBox(),
                spaceWidth(10),
                Text(
                  widget.song.duration! > const Duration(milliseconds: 3600000)
                      ? widget.song.duration!
                          .toFormattedStringWithHoursWithCharacter()
                      : widget.song.duration!
                          .toFormattedStringWithoutHoursWithCharacter(),
                  style: AppFonts.normal_10.copyWith(
                      color: valueNotifier
                          ? AppColor.lightBlue
                          : AppColor.white.withAlpha(120)),
                ),

                //**  Icon */
                widget.isFavorite
                    ? FavoriteIconButton(song: widget.song)
                    : SongMenuButton(
                        song: widget.song,
                        hideIndex: widget.hideIndex,
                      ),
              ],
            ),

            //** title
            title: Text(
              widget.song.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            titleTextStyle: AppFonts.medium_14.copyWith(
                color: valueNotifier ? AppColor.lightBlue : AppColor.white),

            //** subtitle
            subtitle: Text(
              widget.song.artist ?? AppStrings.unknown,
              maxLines: 2,
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
