import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/widgets/custom_title_feature_home_view.dart';
import 'package:just_music/features/home/widgets/most_played/card_most_played.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';

class MostPlayed extends StatelessWidget {
  const MostPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        buildWhen: (previous, current) {
          return previous.mostPlayed != current.mostPlayed;
        },
        builder: (context, state) {
          final mostPlayed = state.mostPlayed;

          // Extract songs from mostPlayed models
          final songs = mostPlayed.map((msp) => msp.song).toList();
          if (state.mostPlayed.isEmpty) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title And icon more
              CustomTitleFeatureHomeView(
                title: AppStrings.mostPlayed,
                onTap: () {},
              ),

              spaceHeight(10),

              // List of Most Played
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: List.generate(mostPlayed.length, (index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        context
                            .read<AudioPlayerBloc>()
                            .add(SetAudioEvent(songs: songs, index: index));
                      },
                      child: CardMostPlayed(
                        mostPlayedModel: mostPlayed[index],
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
