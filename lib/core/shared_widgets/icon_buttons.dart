import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/styling/colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.color,
      this.size});

  final VoidCallback onPressed;
  final IconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color ?? AppColor.white,
          size: size ?? 22.h,
        ));
  }
}
