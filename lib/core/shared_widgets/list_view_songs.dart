import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/song_card.dart';

class SliverListSongs extends StatelessWidget {
  const SliverListSongs({
    super.key,
    required this.songs,
    this.isFavorite = false,
  });
  final List<Song> songs;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, i) {
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
      },
      childCount: songs.length,
    ));
  }
}
