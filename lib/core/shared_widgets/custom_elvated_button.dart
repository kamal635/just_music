import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // color
        backgroundColor: AppColor.orange,

        // radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),

        //padding
        padding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColor.white,
            size: 24.h,
          ),
          spaceWidth(10),
          Text(
            title,
            style: AppFonts.medium_14.copyWith(color: AppColor.white),
          ),
        ],
      ),
    );
  }
}
