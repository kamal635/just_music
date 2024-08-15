import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/navigation.dart';
import '../../../core/routes/string_route.dart';
import '../../../core/shared_widgets/custom_art_work.dart';
import '../../../core/styling/app_colors.dart';
import '../../../core/styling/app_fonts.dart';
import '../../../core/styling/app_linear.dart';
import '../../../core/constant/app_icon.dart';
import '../data/model/playlist_model.dart';

class SliverGridViewPlaylist extends StatefulWidget {
  const SliverGridViewPlaylist({super.key, required this.playlists});
  final List<Playlist> playlists;
  @override
  State<SliverGridViewPlaylist> createState() => _SliverGridViewPlaylistState();
}

class _SliverGridViewPlaylistState extends State<SliverGridViewPlaylist> {
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
        itemCount: widget.playlists.length,
        itemBuilder: (context, i) {
          final playlist = widget.playlists[i];

          //* container playlist
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.pushNamed(
                      RouterName.contentPlaylistBody,
                      arguments: {
                        "index": i,
                        "playlist": playlist,
                      },
                    );
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
                        gradient: AppLinear.listLinearPlayList[
                            i % AppLinear.listLinearPlayList.length],
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          //* image playlist
                          CustomArtWork(
                            id: playlist.songs == null ||
                                    playlist.songs!.isEmpty
                                ? -1
                                : playlist.songs?.first.id ?? -1,
                            iconSize: 66.h,
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

              // *info playlist
              ListTile(
                title: Text(
                  playlist.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppFonts.medium_14,
                ),
                subtitle: Text(
                  "Total ${playlist.numOfSongs} songs",
                  style: AppFonts.normal_10
                      .copyWith(color: AppColor.white.withAlpha(110)),
                ),
              )
            ],
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 12.5.w / 14.h,
        ));
  }
}
