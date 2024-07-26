import 'package:flutter/material.dart';
import 'package:just_music/features/favorites/widgets/favorite_view_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavoriteViewBody(),
    );
  }
}
