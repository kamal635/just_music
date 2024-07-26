import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/styling/app_linear.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';

class SliverGridViewPlaylist extends StatelessWidget {
  const SliverGridViewPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        final playlists = state.playlist;

        return SliverGrid.builder(
            itemCount: playlists!.length,
            itemBuilder: (context, i) {
              final playlist = playlists[i];
              //* container playlist
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(
                          RouterName.playlistSongs,
                          arguments: {
                            "index": i,
                            "playlist": playlist,
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: AppLinear.listLinearPlayList[
                              i % AppLinear.listLinearPlayList.length],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            //* image playlist
                            CustomArtWork(
                              id: playlist.songs == null ||
                                      playlist.songs!.isEmpty
                                  ? -1
                                  : playlist.songs?.first.id ?? -1,
                              iconSize: 66.h,
                            ),

                            //*icon as image
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                  color: AppColor.primary,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    AppIcon.play,
                                    color: AppColor.white,
                                    size: 22.h,
                                  ),
                                  onPressed: null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // *info playlist
                  ListTile(
                    title: Text(
                      playlist.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppFonts.medium_14,
                    ),
                    subtitle: Text(
                      "Total ${playlist.numOfSongs} songs",
                      style: AppFonts.normal_10
                          .copyWith(color: AppColor.white.withAlpha(110)),
                    ),
                  )
                ],
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.55.h,
            ));
      },
    );
  }
}
