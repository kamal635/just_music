import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/albums/logic/albums/albums_bloc.dart';
import 'package:just_music/features/albums/widgets/grid_view_albums.dart';

class AlbumsViewBody extends StatelessWidget {
  const AlbumsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      builder: (context, state) {
        if (state.albumsStatus == AlbumsStatus.loading) {
          return const CustomLoading();
        }
        if (state.albumsStatus == AlbumsStatus.loaded) {
          final albums = state.albums;
          if (albums.isEmpty) {
            return const ImageEmptyList(image: AppImages.emptySongs);
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CustomScrollView(
              slivers: [
                sliverPadding(20),

                // Number albums
                SliverToBoxAdapter(
                  child: Text(
                    "${albums.length} ${AppStrings.albums}",
                    style: AppFonts.bold_18,
                  ),
                ),

                sliverPadding(20),

                // List of albums
                GridViewAlbums(
                  albums: state.albums,
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
