import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/spacer.dart';
import '../styling/app_colors.dart';
import '../styling/app_fonts.dart';
import '../constant/app_strings.dart';

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
