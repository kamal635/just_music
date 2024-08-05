import 'package:flutter/material.dart';
import 'package:just_music/features/home/widgets/recently_played/recently_played_view_body.dart';
import 'package:just_music/features/songs/data/model/song.dart';

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
