import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/home/widgets/song_card.dart';

class ListViewBuilderSongs extends StatelessWidget {
  const ListViewBuilderSongs(
      {super.key, required this.songs, this.isFavorite = false});
  final List<Song> songs;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: songs.length,
        itemBuilder: (context, i) {
          final song = songs[i];
          return InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              context
                  .read<AudioPlayerBloc>()
                  .add(SetAudioEvent(songs: songs, index: i));
            },
            child: SongCard(
              song: song,
              isFavorite: isFavorite,
            ),
          );
        });
  }
}
