import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/styling/app_linear.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';

class ImageAndTitleAndButtonsContentPlaylist extends StatelessWidget {
  const ImageAndTitleAndButtonsContentPlaylist(
      {super.key, required this.playlist, required this.index});
  final int index;
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        // Find the updated playlist from the state
        final updatedPlaylist = state.playlist!.firstWhere(
          (pl) => pl.id == playlist.id,
          orElse: () => playlist,
        );
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //* Image
              Container(
                height: 140.h,
                width: 160.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: AppLinear.listLinearPlayList[
                      index % AppLinear.listLinearPlayList.length],
                ),
                child: CustomArtWork(
                  id: updatedPlaylist.songs == null ||
                          updatedPlaylist.songs!.isEmpty
                      ? -1
                      : updatedPlaylist.songs?.first.id ?? 0,
                  iconSize: 66.h,
                ),
              ),

              spaceHeight(20),

              //* Name Playlist
              Text(
                updatedPlaylist.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppFonts.medium_16,
              ),

              spaceHeight(20),

              //* Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Suffle Button
                  CustomElvatedButton(
                    widthButton: 150.w,
                    onPressed: () {
                      updatedPlaylist.songs == null ||
                              updatedPlaylist.songs!.isEmpty
                          ? null
                          : context.read<AudioPlayerBloc>().add(SetAudioEvent(
                              songs: updatedPlaylist.songs ?? [], index: 0));

                      context.read<AudioPlayerBloc>().add(
                          const ShuffleModeAudioEvent(
                              shuffleMode: AudioServiceShuffleMode.all));
                    },
                    titleWithIcon: AppStrings.shuffle,
                    isIcon: true,
                    icon: AppIcon.shuffle,
                  ),

                  spaceWidth(20),

                  // Play Button
                  CustomElvatedButton(
                    widthButton: 150.w,
                    onPressed: () {
                      updatedPlaylist.songs == null ||
                              updatedPlaylist.songs!.isEmpty
                          ? null
                          : context.read<AudioPlayerBloc>().add(SetAudioEvent(
                              songs: updatedPlaylist.songs ?? [], index: 0));

                      context.read<AudioPlayerBloc>().add(
                          const ShuffleModeAudioEvent(
                              shuffleMode: AudioServiceShuffleMode.none));
                    },
                    titleWithIcon: AppStrings.playAll,
                    isIcon: true,
                    icon: AppIcon.play,
                    colorButton: Colors.transparent,
                    colorBorderSide: AppColor.white,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
