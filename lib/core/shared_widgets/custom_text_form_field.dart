import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.suffixIcon,
  });
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: TextFormField(
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,

        autofocus: autofocus,

        // input decoration
        decoration: InputDecoration(
          // Border
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
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
              AppFonts.medium_12.copyWith(color: AppColor.white.withAlpha(140)),
          hintFadeDuration: Durations.extralong2,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
