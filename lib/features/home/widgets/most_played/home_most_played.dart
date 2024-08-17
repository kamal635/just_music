import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/navigation.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/routes/string_route.dart';
import '../../../../core/constant/app_strings.dart';
import '../custom_title_feature_home_view.dart';
import 'card_most_played.dart';
import '../../../songs/logic/audio_player/audio_player_bloc.dart';

class HomeMostPlayed extends StatefulWidget {
  const HomeMostPlayed({super.key});

  @override
  State<HomeMostPlayed> createState() => _HomeMostPlayedState();
}

class _HomeMostPlayedState extends State<HomeMostPlayed>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

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
          return AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
            child: Column(
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
                spaceHeight(30),
              ],
            ),
          );
        },
      ),
    );
  }
}
