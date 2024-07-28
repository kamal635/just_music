import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/song_menu_button/song_menu_model.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class SongMenuButton extends StatelessWidget {
  const SongMenuButton({super.key, required this.playlist, required this.song});
  final Playlist playlist;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteSongsBloc, FavoriteSongsState>(
      builder: (context, state) {
        return CustomIconButton(
          onPressed: () {
            showModalBottomSheet(
              // to take showModalBottomSheet full height
              isScrollControlled: true,

              // color showModalBottomSheet
              backgroundColor: AppColor.primary,

              context: context,
              builder: (context) {
                return CustomScrollView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    sliverPadding(25),
                    SliverToBoxAdapter(
                      child: ListTile(
                        //* Title Song
                        title: Text(
                          song.title,
                          style: AppFonts.medium_16,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        //* Artist Song
                        subtitle: Text(
                          song.artist ?? AppStrings.unknown,
                          style: AppFonts.normal_12
                              .copyWith(color: AppColor.white.withAlpha(110)),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    //* list of actions menu button
                    SliverList.builder(
                      itemCount: SongMenuModel.listSongMenu(
                              song, state.favoriteSong, playlist)
                          .length,
                      itemBuilder: (context, index) {
                        final songMenuModel = SongMenuModel.listSongMenu(
                            song, state.favoriteSong, playlist)[index];
                        return InkWell(
                          onTap: () {
                            songMenuModel.action.execute(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(4.h),
                            child: ListTile(
                              leading: Container(
                                height: 28.h,
                                width: 28.h,
                                decoration: BoxDecoration(
                                    color: AppColor.secondary,
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: Icon(
                                  songMenuModel.icon,
                                  color: songMenuModel.colorIcon,
                                  size: 18.h,
                                ),
                              ),
                              title: Text(
                                songMenuModel.name,
                                style: AppFonts.medium_12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    sliverPadding(25),
                  ],
                );
              },
            );
          },
          icon: AppIcon.threeDotVertical,
        );
      },
    );
  }
}
