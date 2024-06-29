import 'package:flutter/material.dart';
import 'package:just_music/features/home/widgets/home_view_body.dart';
import 'package:just_music/features/home/widgets/music_track/music_track_player.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: MusicTrackPlayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: HomeViewBody(),
    );
  }
}
