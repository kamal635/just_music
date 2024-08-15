import 'package:flutter/material.dart';
import 'recently_played_view_body.dart';
import '../../../songs/data/model/song.dart';

class RecentlyPlayedView extends StatelessWidget {
  const RecentlyPlayedView({super.key, required this.recentlyPlayed});
  final List<Song> recentlyPlayed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecentlyPlayedViewBody(
        songs: recentlyPlayed,
      ),
    );
  }
}
