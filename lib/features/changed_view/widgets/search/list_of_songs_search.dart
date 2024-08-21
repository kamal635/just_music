import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/constant/app_images.dart';
import 'package:just_music/core/constant/app_strings.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/shared_widgets/custom_loading.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/styling/app_fonts.dart';
import '../../../songs/logic/audio_player/audio_player_bloc.dart';
import '../../logic/search_songs/search_songs_bloc.dart';

class ListOfSongsSearch extends StatelessWidget {
  const ListOfSongsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchSongsBloc, SearchSongsState>(
      builder: (context, state) {
        if (state.searchStatus == SearchStatus.loading) {
          return const CustomLoading();
        }

        if (state.searchStatus == SearchStatus.noResault) {
          return const ImageEmptyList(
            image: AppImages.emptySearch,
            title: AppStrings.noResault,
          );
        }

        if (state.searchStatus == SearchStatus.loaded &&
            state.songs != null &&
            state.songs!.isNotEmpty) {
          return Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final song = state.songs![i];
                      return InkWell(
                        onTap: () {
                          // Handle song tap
                          context.read<AudioPlayerBloc>().add(
                              SetAudioEvent(songs: state.songs!, index: i));
                          context
                              .read<SearchSongsBloc>()
                              .add(ResetSearchEvent());
                          Navigator.pop(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.title,
                              style: AppFonts.medium_12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            spaceHeight(5),
                            Divider(
                              thickness: 0.5,
                              color: AppColor.white.withAlpha(40),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: state.songs!.length,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
