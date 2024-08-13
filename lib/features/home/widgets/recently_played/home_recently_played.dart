import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/widgets/custom_title_feature_home_view.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/song_card.dart';

class HomeRecentlyPlayed extends StatefulWidget {
  const HomeRecentlyPlayed({super.key});

  @override
  _HomeRecentlyPlayedState createState() => _HomeRecentlyPlayedState();
}

class _HomeRecentlyPlayedState extends State<HomeRecentlyPlayed>
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
          return previous.recentlyPlayed != current.recentlyPlayed;
        },
        builder: (context, state) {
          final recentPlayed = state.recentlyPlayed;
          final endIndex = recentPlayed.length < 3 ? recentPlayed.length : 3;
          final subList = recentPlayed.sublist(0, endIndex);

          if (state.recentlyPlayed.isEmpty) {
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
                  title: AppStrings.recentlyPlayed,
                  onTap: () {
                    context
                        .pushNamed(RouterName.recentlyPlayedView, arguments: {
                      "songs": recentPlayed,
                    });
                  },
                ),

                spaceHeight(5),

                // List of songs in Recently Played display 3 songs just
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subList.length,
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
                        hideIndex: 2,
                      ),
                    );
                  },
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
