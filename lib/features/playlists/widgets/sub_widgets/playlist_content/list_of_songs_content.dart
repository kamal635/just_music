import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/song_menu_button/song_menu_button.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/song_card.dart';

class ListOfSongsContentPlaylist extends StatelessWidget {
  const ListOfSongsContentPlaylist(
      {super.key, required this.songs, required this.playlist});
  final List<Song> songs;
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
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
            isIcon: true,
            widgetIcon: SongMenuButton(playlist: playlist, song: song),
          ),
        );
      },
    );
  }
}
