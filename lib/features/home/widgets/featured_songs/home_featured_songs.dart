import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../changed_view/logic/nav_bottom_bar/nav_bottom_bar_bloc.dart';
import '../custom_title_feature_home_view.dart';
import 'card_featured_songs.dart';
import '../../../songs/logic/audio_player/audio_player_bloc.dart';
import '../../../songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

class HomeFeaturedSongs extends StatefulWidget {
  const HomeFeaturedSongs({super.key});

  @override
  State<HomeFeaturedSongs> createState() => _HomeFeaturedSongsState();
}

class _HomeFeaturedSongsState extends State<HomeFeaturedSongs>
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
      child: BlocBuilder<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
        builder: (context, state) {
          if (state.fixedSongs.isEmpty) {
            return const SizedBox();
          }
          final songs = state.fixedSongs;
          final subSongs = songs.take(12).toList();
          return AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                // title list of featured songs
                CustomTitleFeatureHomeView(
                  onTap: () {
                    context
                        .read<NavBottomBarBloc>()
                        .add(const ChangedCurrentPageEvent(index: 1));
                  },
                  title: AppStrings.featuredSongs,
                ),

                spaceHeight(10),

                // GridView Featured Songs
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: SizedBox(
                    height: 160.h,
                    child: GridView.builder(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: subSongs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16.h,
                        mainAxisSpacing: 25.w,
                        childAspectRatio: 1 / 5,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(12.r),
                          onTap: () {
                            context
                                .read<AudioPlayerBloc>()
                                .add(SetAudioEvent(songs: songs, index: index));
                          },
                          child: CardFeaturedHomeView(
                            song: subSongs[index],
                          ),
                        );
                      },
                    ),
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
