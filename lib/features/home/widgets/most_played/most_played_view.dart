import 'package:flutter/material.dart';
import 'most_played_view_body.dart';
import '../../../songs/data/model/song.dart';

class MostPlayedView extends StatelessWidget {
  const MostPlayedView({super.key, required this.songs});
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MostPlayedViewBody(
        songs: songs,
      ),
    );
  }
}
