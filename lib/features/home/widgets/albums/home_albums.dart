import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/albums/logic/albums/albums_bloc.dart';
import 'package:just_music/features/changed_view/logic/nav_bottom_bar/nav_bottom_bar_bloc.dart';
import 'package:just_music/features/home/widgets/custom_title_feature_home_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeFeaturedAlbums extends StatelessWidget {
  const HomeFeaturedAlbums({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      builder: (context, state) {
        final orginaAlbums = state.albums;
        const endIndex = 5;
        final subAlbums = orginaAlbums.sublist(
            0, endIndex > orginaAlbums.length ? orginaAlbums.length : endIndex);
        if (subAlbums.isEmpty) {
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
                  title: AppStrings.featuredAlbums,
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
                    subAlbums.length,
                    (index) {
                      final album = subAlbums[index];
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 80.h,
                                  width: 100.w,
                                  child: CustomArtWork(
                                    id: album.id,
                                    artworkType: ArtworkType.ALBUM,
                                    isNullImage: true,
                                    nullArtworkWidget: AppImages.album,
                                  )),
                              spaceHeight(5),
                              SizedBox(
                                width: 100.w,
                                child: Text(
                                  album.album,
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
