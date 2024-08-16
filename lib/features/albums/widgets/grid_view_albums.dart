import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/navigation.dart';
import '../../../core/helpers/spacer.dart';
import '../../../core/routes/string_route.dart';
import '../../../core/shared_widgets/custom_art_work.dart';
import '../../../core/styling/app_colors.dart';
import '../../../core/styling/app_fonts.dart';
import '../../../core/constant/app_icon.dart';
import '../../../core/constant/app_images.dart';
import '../../../core/constant/app_strings.dart';
import '../data/model/album.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GridViewAlbums extends StatefulWidget {
  const GridViewAlbums({super.key, required this.albums});
  final List<Album> albums;
  @override
  State<GridViewAlbums> createState() => _GridViewAlbumsState();
}

class _GridViewAlbumsState extends State<GridViewAlbums> {
  bool _isFieldVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isFieldVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: widget.albums.length,
        itemBuilder: (context, i) {
          final album = widget.albums[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.pushNamed(RouterName.AlbumSongs, arguments: {
                      AppArguments.album: album,
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    transform: _isFieldVisible
                        ? Matrix4.translationValues(0, 0, 0)
                        : Matrix4.translationValues(-50.w, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // //* image Albums
                          CustomArtWork(
                            id: album.id,
                            iconSize: 66.h,
                            artworkType: ArtworkType.ALBUM,
                            isNullImage: true,
                            nullArtworkWidget: AppImages.album,
                          ),

                          //*icon as image
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.r),
                                color: AppColor.primary,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  AppIcon.play,
                                  color: AppColor.white,
                                  size: 22.h,
                                ),
                                onPressed: null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              spaceHeight(6),
              // *Albums Name
              Text(
                album.album,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppFonts.medium_14,
              )
            ],
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 12.5.w / 11.h,
        ));
  }
}
