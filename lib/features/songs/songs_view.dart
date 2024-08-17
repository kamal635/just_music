import 'package:flutter/material.dart';
import 'widgets/songs_view_body.dart';

class SongsView extends StatelessWidget {
  const SongsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SongsViewBody(),
    );
  }
}
