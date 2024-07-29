import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      this.titleWithIcon,
      this.icon,
      required this.onPressed,
      this.title,
      this.isIcon = false,
      this.colorButton,
      this.widthButton,
      this.colorBorderSide});
  final String? titleWithIcon;
  final String? title;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isIcon;
  final Color? colorButton;
  final Color? colorBorderSide;
  final double? widthButton;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton ?? AppColor.secondary,
          shadowColor: Colors.transparent,
          side: BorderSide(
              color: colorBorderSide ?? Colors.transparent, width: 0.5),
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
