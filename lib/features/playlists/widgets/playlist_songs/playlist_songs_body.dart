import 'package:flutter/material.dart';

import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/widgets/playlist_songs/appbar_playlist_songs.dart';

class PlaylistSongsBody extends StatelessWidget {
  const PlaylistSongsBody({super.key, required this.playlist});
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PlaylistSongAppBar(),
      body: CustomScrollView(),
    );
  }
}
