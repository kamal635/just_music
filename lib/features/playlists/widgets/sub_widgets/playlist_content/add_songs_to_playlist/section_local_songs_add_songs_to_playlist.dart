import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/helpers/navigation.dart';
import '../../../../../../core/routes/string_route.dart';
import '../../../../../../core/styling/app_colors.dart';
import '../../../../../../core/constant/app_icon.dart';
import '../../../../../../core/constant/app_strings.dart';
import '../../../../data/model/playlist_model.dart';
import 'card_add_songs_to_playlist.dart';
import '../../../../../songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

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
            colorCard: AppColor.lightBlue.withAlpha(110),
            colorIcon: AppColor.lightBlue,
            title: AppStrings.localSongs,
            isTrailing: true,
            subtitle: state.songs.length,
          ),
        );
      },
    );
  }
}
