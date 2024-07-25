import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/favorite_icon_button.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/song_card.dart';

class CustomSliverListSongs extends StatelessWidget {
  const CustomSliverListSongs({
    super.key,
    required this.songs,
    this.isIcon = false,
    this.widgetIcon,
  });
  final List<Song> songs;
  final bool isIcon;
  final Widget? widgetIcon;
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
            isIcon: isIcon,
            widgetIcon: widgetIcon ?? FavoriteIconButton(song: song),
          ),
        );
      },
      childCount: songs.length,
    ));
  }
}
