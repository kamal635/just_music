import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/song_card.dart';

class ListOfSongsContentPlaylist extends StatefulWidget {
  const ListOfSongsContentPlaylist(
      {super.key, required this.songs, required this.playlist});
  final List<Song> songs;
  final Playlist playlist;

  @override
  State<ListOfSongsContentPlaylist> createState() =>
      _ListOfSongsContentPlaylistState();
}

class _ListOfSongsContentPlaylistState
    extends State<ListOfSongsContentPlaylist> {
  bool _isListVisible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isListVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: widget.songs.length,
      itemBuilder: (context, i) {
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
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: SongCard(
              song: song,
            ),
          ),
        );
      },
    );
  }
}
