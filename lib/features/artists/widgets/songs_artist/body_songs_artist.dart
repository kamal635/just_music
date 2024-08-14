import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/features/artists/data/model/artists.dart';
import 'package:just_music/features/artists/logic/songs_artist/songs_artist_bloc.dart';
import 'package:just_music/features/artists/widgets/songs_artist/section_albums_songs_artist.dart';
import 'package:just_music/features/artists/widgets/songs_artist/section_buttons_songs_artist.dart';
import 'package:just_music/features/artists/widgets/songs_artist/section_songs_artist.dart';
import 'package:just_music/features/artists/widgets/songs_artist/sliver_appbar_songs_artist.dart';
import 'package:just_music/features/songs/widgets/music_track/music_track_player.dart';

class SongsArtist extends StatelessWidget {
  const SongsArtist({super.key, required this.artist});
  final Artist artist;
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
      create: (context) => di<SongsArtistBloc>()
        ..add(LoadSongsArtistByIdEvent(artistId: artist.id)),
      child: Scaffold(
        floatingActionButton: const MusicTrackPlayer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocBuilder<SongsArtistBloc, SongsArtistState>(
          builder: (context, state) {
            final songs = state.songs;
            if (state.songsArtistStatus == SongsArtistStatus.loading) {
              return const CustomLoading();
            }
            if (state.songsArtistStatus == SongsArtistStatus.loaded) {
              if (songs.isEmpty) {
                return const ImageEmptyList(image: AppImages.emptySongs);
              }
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  //* Sliver Appbar
                  SliverAppBarSongsArtist(
                      screenHeight: screenHeight, artist: artist),

                  sliverPadding(20),

                  //* Albums
                  SectionAlbumsInSongsArtist(artist: artist),

                  sliverPadding(20),

                  //* Butons
                  SectionButtonsSongsArtist(songs: songs),

                  sliverPadding(20),

                  //* Songs
                  SectionSongsInSongsArtist(songs: songs),

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
