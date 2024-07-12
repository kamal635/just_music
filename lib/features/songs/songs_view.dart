import 'package:flutter/material.dart';
import 'package:just_music/features/songs/widgets/songs_view_body.dart';

class SongsView extends StatelessWidget {
  const SongsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SongsViewBody(),
    );
  }
}
