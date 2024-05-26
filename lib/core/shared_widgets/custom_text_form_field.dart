import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, this.hintText, this.prefixIcon});
  final String? hintText;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: TextFormField(
        // input decoration
        decoration: InputDecoration(
          // Border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),

          // Enabled border
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide.none),

          // Property TextFormField
          filled: true,
          fillColor: AppColor.white.withAlpha(40),
          contentPadding: EdgeInsets.all(10.r),
          hintText: hintText,
          hintStyle:
              AppFonts.medium_14.copyWith(color: AppColor.white.withAlpha(140)),
          hintFadeDuration: Durations.extralong2,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
