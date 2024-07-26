import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/card_add_songs_to_playlist.dart';
import 'package:just_music/features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

class SectionLocalSongsAddSongsToPlaylist extends StatelessWidget {
  const SectionLocalSongsAddSongsToPlaylist(
      {super.key, required this.playlistComeFromPreviousPage});
  final Playlist playlistComeFromPreviousPage;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.pushNamed(
                RouterName.listOfSongsLocalSongsToAddToAddToPlaylist,
                arguments: {
                  AppArguments.songs: state.songs,
                  AppArguments.playlistComeFromPreviousPage:
                      playlistComeFromPreviousPage,
                });
          },
          child: CustomCardAddSongToPlaylist(
            icon: AppIcon.folder,
            colorCard: AppColor.folder.withAlpha(110),
            colorIcon: AppColor.folder,
            title: AppStrings.localSongs,
            subtitle: state.songs?.length ?? 0,
          ),
        );
      },
    );
  }
}
