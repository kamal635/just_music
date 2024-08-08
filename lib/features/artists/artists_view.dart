import 'package:flutter/material.dart';
import 'package:just_music/features/artists/widgets/artist_view_body.dart';

class ArtistsView extends StatelessWidget {
  const ArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ArtistsViewBody(),
    );
  }
}
