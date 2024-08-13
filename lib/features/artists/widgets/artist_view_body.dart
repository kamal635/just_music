import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/artists/logic/artists/artists_bloc.dart';
import 'package:just_music/features/artists/widgets/grid_view_artists.dart';

class ArtistsViewBody extends StatelessWidget {
  const ArtistsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistsBloc, ArtistsState>(
      builder: (context, state) {
        if (state.artistsStatus == ArtistsStatus.loading) {
          return const CustomLoading();
        }
        if (state.artistsStatus == ArtistsStatus.loaded) {
          final artists = state.artists;
          if (artists.isEmpty) {
            return const ImageEmptyList(image: AppImages.emptyFavorites);
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CustomScrollView(
              slivers: [
                sliverPadding(20),

                // Number artists
                SliverToBoxAdapter(
                  child: Text(
                    "${artists.length} ${AppStrings.artists}",
                    style: AppFonts.bold_18,
                  ),
                ),

                sliverPadding(20),

                // List of artist
                GridViewArtists(
                  artists: state.artists,
                ),
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
