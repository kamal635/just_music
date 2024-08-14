import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/features/albums/data/model/album.dart';
import 'package:just_music/features/albums/logic/songs_album/songs_albums_bloc.dart';
import 'package:just_music/features/albums/widgets/songs_album/section_buttons_songs_album.dart';
import 'package:just_music/features/albums/widgets/songs_album/section_songs_album.dart';
import 'package:just_music/features/albums/widgets/songs_album/sliver_appbar_songs_album.dart';
import 'package:just_music/features/songs/widgets/music_track/music_track_player.dart';

class SongsAlbum extends StatelessWidget {
  const SongsAlbum({super.key, required this.album});
  final Album album;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    Map<int, double> paddingMap = {
      0: screenHeight,
      1: screenHeight / 2,
      2: screenHeight / 2,
      3: screenHeight / 2,
      4: screenHeight / 2.8,
      5: screenHeight / 2.8,
      6: screenHeight / 2.8,
      7: screenHeight / 2.8,
      8: screenHeight / 7.2,
      9: screenHeight / 7.2,
    };

    double calculatePadding(int lenght) {
      return paddingMap[lenght] ?? screenHeight / 8;
    }

    return BlocProvider(
      create: (context) => di<SongsAlbumsBloc>()
        ..add(LoadSongsAlbumByIdEvent(albumId: album.id)),
      child: Scaffold(
        floatingActionButton: const MusicTrackPlayer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocBuilder<SongsAlbumsBloc, SongsAlbumsState>(
          builder: (context, state) {
            final songs = state.songs;
            if (state.songsAlbumStatus == SongsAlbumStatus.loading) {
              return const CustomLoading();
            }
            if (state.songsAlbumStatus == SongsAlbumStatus.loaded) {
              if (songs.isEmpty) {
                return const ImageEmptyList(image: AppImages.emptySongs);
              }
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  //* Sliver Appbar
                  SliverAppBarSongsAlbum(
                      screenHeight: screenHeight, album: album),

                  sliverPadding(20),

                  //* Butons
                  SectionButtonsSongsAlbum(songs: songs),

                  sliverPadding(20),

                  //* Songs
                  SectionSongsInSongsAlbum(songs: songs),

                  sliverPadding(calculatePadding(songs.length)),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
