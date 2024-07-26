import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/card_add_songs_to_playlist.dart';

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
                      RouterName.listOfSongsPlaylistSongsToAddToAddToPlaylist,
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
