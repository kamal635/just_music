import 'package:flutter/material.dart';
import 'package:just_music/core/shared_widgets/custom_app_bar.dart';
import 'package:just_music/features/details_song/widgets/details_song_body.dart';
import 'package:just_music/features/home/data/model/song.dart';

class DetailsSongView extends StatelessWidget {
  const DetailsSongView({super.key, required this.song});
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: DetailsSongViewBody(
        song: song,
      ),
    );
  }
}
