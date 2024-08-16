import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/helpers/navigation.dart';
import '../../../../../../core/routes/string_route.dart';
import '../../../../../../core/constant/app_strings.dart';
import '../../../../data/model/playlist_model.dart';
import '../../../../logic/playlist/playlist_bloc.dart';
import 'card_add_songs_to_playlist.dart';

class SectionPlaylistsAddSongsToPlaylist extends StatelessWidget {
  const SectionPlaylistsAddSongsToPlaylist(
      {super.key, required this.playlistComeFromPreviousPage});
  final Playlist playlistComeFromPreviousPage;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        return SliverList.builder(
          itemCount: state.playlist!.length,
          itemBuilder: (context, index) {
            final playlist = state.playlist![index];

            // check if playlist return true show sizedbox
            // Because I am coming from the playlist to which I want to add songs
            // It should not be displayed here
            if (playlistComeFromPreviousPage.id != playlist.id &&
                playlist.songs!.isNotEmpty) {
              return InkWell(
                onTap: () {
                  context.pushNamed(
                      RouterName.listOfSongsPlaylistSongsToAddToPlaylist,
                      arguments: {
                        AppArguments.songs: playlist.songs,
                        AppArguments.playlist: playlist,
                        AppArguments.playlistComeFromPreviousPage:
                            playlistComeFromPreviousPage,
                      });
                },
                child: CustomCardAddSongToPlaylist(
                  index: index,
                  title: playlist.name,
                  subtitle: playlist.songs!.length,
                  isArtwork: true,
                  isTrailing: true,
                  artworkId: playlist.songs == null || playlist.songs!.isEmpty
                      ? -1
                      : playlist.songs?.first.id ?? -1,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}
