import 'package:flutter/material.dart';
import 'package:just_music/features/playlists/widgets/playlist_view_body.dart';

class PlayListView extends StatelessWidget {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PlayListViewBody(),
    );
  }
}
