import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/artists/logic/artists/artists_bloc.dart';
import 'package:just_music/features/changed_view/logic/nav_bottom_bar/nav_bottom_bar_bloc.dart';
import 'package:just_music/features/home/widgets/custom_title_feature_home_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeFeaturedArtists extends StatelessWidget {
  const HomeFeaturedArtists({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistsBloc, ArtistsState>(
      builder: (context, state) {
        final orginaArtists = state.artists;
        const endIndex = 5;
        final subArtists = orginaArtists.sublist(0,
            endIndex > orginaArtists.length ? orginaArtists.length : endIndex);
        if (orginaArtists.isEmpty) {
          return const SliverToBoxAdapter(
            child: SizedBox(),
          );
        }

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTitleFeatureHomeView(
                  title: AppStrings.featuredArtists,
                  onTap: () {
                    context
                        .read<NavBottomBarBloc>()
                        .add(const ChangedCurrentPageEvent(index: 1));
                  }),
              spaceHeight(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    subArtists.length,
                    (index) {
                      final artist = subArtists[index];
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          context.pushNamed(RouterName.songsArtist, arguments: {
                            AppArguments.artist: artist,
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 80.h,
                                  width: 100.w,
                                  child: CustomArtWork(
                                    id: artist.id,
                                    artworkType: ArtworkType.ARTIST,
                                    isNullImage: true,
                                    nullArtworkWidget: AppImages.artist,
                                  )),
                              spaceHeight(5),
                              SizedBox(
                                width: 100.w,
                                child: Text(
                                  artist.artist,
                                  style: AppFonts.normal_12,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
