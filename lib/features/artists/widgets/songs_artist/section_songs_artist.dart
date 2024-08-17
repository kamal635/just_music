import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../songs/data/model/song.dart';
import '../../../songs/logic/audio_player/audio_player_bloc.dart';
import '../../../songs/widgets/song_card.dart';

class SectionSongsInSongsArtist extends StatelessWidget {
  const SectionSongsInSongsArtist({
    super.key,
    required this.songs,
  });

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: InkWell(
                  onTap: () {
                    context
                        .read<AudioPlayerBloc>()
                        .add(SetAudioEvent(songs: songs, index: index));
                  },
                  child: SongCard(
                    song: songs[index],
                    hideIndex: 2,
                  ),
                ),
              ),
            ],
          );
        },
        childCount: songs.length,
      ),
    );
  }
}
