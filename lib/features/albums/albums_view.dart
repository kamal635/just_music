import 'package:flutter/material.dart';
import 'package:just_music/features/albums/widgets/album_view_body.dart';

class AlbumsView extends StatelessWidget {
  const AlbumsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AlbumsViewBody(),
    );
  }
}
