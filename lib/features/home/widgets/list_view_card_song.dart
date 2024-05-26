import 'package:flutter/material.dart';
import 'package:just_music/features/home/widgets/card_song.dart';

class ListViewCardSong extends StatelessWidget {
  const ListViewCardSong({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 40,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {},
            child: const CardSong(),
          );
        });
  }
}