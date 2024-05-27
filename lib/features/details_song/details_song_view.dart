import 'package:flutter/material.dart';
import 'package:just_music/core/shared_widgets/custom_app_bar.dart';
import 'package:just_music/features/details_song/widgets/details_song_body.dart';

class DetailsSongView extends StatelessWidget {
  const DetailsSongView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: DetailsSongViewBody(),
    );
  }
}
