import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/logic/search_songs/search_songs_bloc.dart';

class ListOfSongsSearch extends StatelessWidget {
  const ListOfSongsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchSongsBloc, SearchSongsState>(
      //* Builder
      builder: (context, state) {
        final songs = state.songs;
        final loading = state.searchStatus == SearchStatus.loading;
        final loaded = state.searchStatus == SearchStatus.loaded;

        // Loading
        if (loading) {
          return const CustomLoading();
        }

        // Empty list of songs
        if (songs == null || songs.isEmpty) {
          return const Center(child: Text(""));
        }

        // Loaded
        if (loaded) {
          return Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: songs.length,
                  (context, i) {
                    final song = songs[i];
                    return InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () {
                        // play songs when return from search
                        context
                            .read<AudioPlayerBloc>()
                            .add(SetAudioEvent(songs: songs, index: i));

                        // add event reset to clear list of songs
                        // when push to it again
                        context.read<SearchSongsBloc>().add(ResetSearchEvent());

                        // pop when press on songs
                        context.pop();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // title song from search
                          Text(
                            song.title,
                            style: AppFonts.medium_12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          spaceHeight(5),

                          // divider
                          Divider(
                            thickness: 0.5,
                            color: AppColor.white.withAlpha(40),
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
