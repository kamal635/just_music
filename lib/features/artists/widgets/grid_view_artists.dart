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
import '../data/model/artists.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GridViewArtists extends StatefulWidget {
  const GridViewArtists({super.key, required this.artists});
  final List<Artist> artists;
  @override
  State<GridViewArtists> createState() => _GridViewArtistsState();
}

class _GridViewArtistsState extends State<GridViewArtists> {
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
        itemCount: widget.artists.length,
        itemBuilder: (context, i) {
          final artist = widget.artists[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.pushNamed(RouterName.artistSongs, arguments: {
                      AppArguments.artist: artist,
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
                          // //* image Artists

                          CustomArtWork(
                            id: artist.id,
                            iconSize: 66.h,
                            artworkType: ArtworkType.ARTIST,
                            isNullImage: true,
                            nullArtworkWidget: AppImages.artist,
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
              // *Artists Name
              Text(
                artist.artist,
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
