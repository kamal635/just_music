import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/widgets/custom_title_feature_home_view.dart';
import 'package:just_music/features/home/widgets/most_played/card_most_played.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';

class HomeMostPlayed extends StatelessWidget {
  const HomeMostPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        buildWhen: (previous, current) {
          return previous.mostPlayed != current.mostPlayed;
        },
        builder: (context, state) {
          final mostPlayed = state.mostPlayed;

          final endIndex = mostPlayed.length < 4 ? mostPlayed.length : 4;
          final subList = mostPlayed.sublist(0, endIndex);

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
                onTap: () {
                  context.pushNamed(RouterName.mostPlayedView, arguments: {
                    AppArguments.songs: songs,
                  });
                },
              ),

              spaceHeight(10),

              // List of Most Played
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: List.generate(subList.length, (index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        context
                            .read<AudioPlayerBloc>()
                            .add(SetAudioEvent(songs: songs, index: index));
                      },
                      child: CardMostPlayed(
                        mostPlayedModel: subList[index],
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
