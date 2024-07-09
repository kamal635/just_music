import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';

class ImageEmptyList extends StatelessWidget {
  const ImageEmptyList({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 50.h,
            ),
            spaceHeight(10),
            Text(
              AppStrings.emptySongs,
              style: AppFonts.normal_12
                  .copyWith(color: AppColor.white.withAlpha(160)),
            ),
          ],
        ),
      ),
    );
  }
}
