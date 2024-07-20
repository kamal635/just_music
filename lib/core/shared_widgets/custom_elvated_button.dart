import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton(
      {super.key,
      this.titleWithIcon,
      this.icon,
      required this.onPressed,
      this.title,
      this.isIcon = false,
      this.color,
      this.widthButton});
  final String? titleWithIcon;
  final String? title;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isIcon;
  final Color? color;
  final double? widthButton;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton ?? 100.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColor.secondary,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: isIcon
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: AppColor.white,
                    size: 20.h,
                  ),
                  spaceWidth(10),
                  Text(
                    titleWithIcon ?? "",
                    style: AppFonts.medium_12.copyWith(color: AppColor.white),
                  ),
                ],
              )
            : Text(
                title ?? "",
                style: AppFonts.medium_12.copyWith(color: AppColor.white),
              ),
      ),
    );
  }
}
