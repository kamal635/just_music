import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/song_card.dart';

class CustomSliverListSongs extends StatefulWidget {
  const CustomSliverListSongs({
    super.key,
    required this.songs,
    this.hideIndex,
  });

  final List<Song> songs;
  final int? hideIndex;

  @override
  State<CustomSliverListSongs> createState() => _CustomSliverListSongsState();
}

class _CustomSliverListSongsState extends State<CustomSliverListSongs> {
  bool _isListVisible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _isListVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          final song = widget.songs[i];
          return InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              context
                  .read<AudioPlayerBloc>()
                  .add(SetAudioEvent(songs: widget.songs, index: i));
            },
            child: AnimatedOpacity(
              opacity: _isListVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeIn,
              child: SongCard(
                song: song,
                hideIndex: widget.hideIndex,
              ),
            ),
          );
        },
        childCount: widget.songs.length,
      ),
    );
  }
}
