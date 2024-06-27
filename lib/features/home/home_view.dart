import 'package:flutter/material.dart';
import 'package:just_music/features/home/widgets/home_view_body.dart';
import 'package:just_music/features/home/widgets/music_track/music_track_player.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: MusicTrackPlayer(),
      body: HomeViewBody(),
    );
  }
}
