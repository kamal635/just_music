import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacer.dart';
import '../../../../../core/shared_widgets/custom_art_work.dart';
import '../../../../../core/shared_widgets/custom_shuffle_and_play_all_buttons.dart';
import '../../../../../core/styling/app_fonts.dart';
import '../../../../../core/styling/app_linear.dart';
import '../../../data/model/playlist_model.dart';
import '../../../logic/playlist/playlist_bloc.dart';

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

              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CustomShuffleAndPlayAllButtons(
                    songs: updatedPlaylist.songs),
              )
            ],
          ),
        );
      },
    );
  }
}
