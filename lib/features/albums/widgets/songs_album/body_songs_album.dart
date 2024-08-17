import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/dependencey_injection.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/shared_widgets/custom_loading.dart';
import '../../../../core/shared_widgets/image_empty_list.dart';
import '../../../../core/constant/app_images.dart';
import '../../data/model/album.dart';
import '../../logic/songs_album/songs_albums_bloc.dart';
import 'section_buttons_songs_album.dart';
import 'section_songs_album.dart';
import 'sliver_appbar_songs_album.dart';
import '../../../songs/widgets/music_track/music_track_player.dart';

class AlbumSongs extends StatelessWidget {
  const AlbumSongs({super.key, required this.album});
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
