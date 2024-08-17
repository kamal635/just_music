import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/spacer.dart';
import '../../../core/shared_widgets/custom_loading.dart';
import '../../../core/shared_widgets/image_empty_list.dart';
import '../../../core/styling/app_fonts.dart';
import '../../../core/constant/app_images.dart';
import '../../../core/constant/app_strings.dart';
import '../logic/albums/albums_bloc.dart';
import 'grid_view_albums.dart';

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
            return const ImageEmptyList(image: AppImages.emptyAlbums);
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
                sliverPadding(80),
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
