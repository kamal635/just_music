import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/widgets/custom_title_feature_home_view.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/song_menu_button/song_menu_button.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/song_card.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          final recentPlayed = state.recentlyPlayed;

          if (state.recentlyPlayed.isEmpty) {
            return const SizedBox();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title And icon more
              CustomTitleFeatureHomeView(
                title: AppStrings.recentlyPlayed,
                onTap: () {},
              ),

              spaceHeight(5),

              // List of songs in Recently Played display 3 songs just
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentPlayed.length,
                itemBuilder: (context, index) {
                  final songRecentlyPlayed = state.recentlyPlayed[index];
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      context.read<AudioPlayerBloc>().add(
                          SetAudioEvent(songs: recentPlayed, index: index));
                    },
                    child: SongCard(
                      song: songRecentlyPlayed,
                      isIcon: true,
                      widgetIcon: SongMenuButton(song: songRecentlyPlayed),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
