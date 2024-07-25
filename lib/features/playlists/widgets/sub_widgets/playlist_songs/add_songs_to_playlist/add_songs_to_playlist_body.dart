import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_songs/add_songs_to_playlist/appbar_add_song_to_playlist.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_songs/add_songs_to_playlist/card_add_songs_to_playlist.dart';
import 'package:just_music/features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

class AddSongsToPlayListsBody extends StatelessWidget {
  const AddSongsToPlayListsBody(
      {super.key, required this.playlistComeFromPreviousPage});
  final Playlist playlistComeFromPreviousPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAddSongsToPlaylist(),
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              sliverPadding(10),

              // * (Favorite and local songs)
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    //******* Favorite */
                    BlocBuilder<FavoriteSongsBloc, FavoriteSongsState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            context.pushNamed(
                                RouterName
                                    .listOfSongsFavoriteToAddToAddToPlaylist,
                                arguments: {
                                  "favoriteSong": state.favoriteSong,
                                  "playlist": playlistComeFromPreviousPage,
                                  "playlistComeFromPreviousPage":
                                      playlistComeFromPreviousPage,
                                });
                          },
                          child: CustomCardAddSongToPlaylist(
                            icon: AppIcon.favoriteFilled,
                            colorCard: AppColor.red.withAlpha(110),
                            colorIcon: AppColor.red,
                            title: "Favorite songs",
                            subtitle:
                                state.favoriteSong?.favoriteSongs.length ?? 0,
                          ),
                        );
                      },
                    ),

                    //******* Local */
                    BlocBuilder<FetchSongsFromDeviceBloc,
                        FetchSongsFromDeviceState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            context.pushNamed(
                                RouterName
                                    .listOfSongsLocalSongsToAddToAddToPlaylist,
                                arguments: {
                                  "songs": state.songs,
                                  "playlist": playlistComeFromPreviousPage,
                                  "playlistComeFromPreviousPage":
                                      playlistComeFromPreviousPage,
                                });
                          },
                          child: CustomCardAddSongToPlaylist(
                            icon: AppIcon.folder,
                            colorCard: AppColor.folder.withAlpha(110),
                            colorIcon: AppColor.folder,
                            title: "Local songs",
                            subtitle: state.songs?.length ?? 0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // * List of Playlist
              SliverList.builder(
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
                            RouterName
                                .listOfSongsPlaylistSongsToAddToAddToPlaylist,
                            arguments: {
                              "songs": playlist.songs ?? [],
                              "playlist": playlist,
                              "playlistComeFromPreviousPage":
                                  playlistComeFromPreviousPage,
                            });
                      },
                      child: CustomCardAddSongToPlaylist(
                        index: index,
                        title: playlist.name,
                        subtitle: playlist.songs!.length,
                        isArtwork: true,
                        isTrailing: true,
                        artworkId:
                            playlist.songs == null || playlist.songs!.isEmpty
                                ? -1
                                : playlist.songs?.first.id ?? -1,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              sliverPadding(kTextTabBarHeight + 80.h),
            ],
          );
        },
      ),
    );
  }
}
