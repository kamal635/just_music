import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/features/home/data/model/song.dart';

class ImageDetailsSong extends StatelessWidget {
  const ImageDetailsSong({super.key, required this.song});

  final Song? song;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomArtWork(
        id: song!.id,
        radius: 10.r,
        iconSize: 80.h,
      ),
    );
  }
}
