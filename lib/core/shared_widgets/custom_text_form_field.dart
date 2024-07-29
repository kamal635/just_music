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
    this.onSaved,
    this.initialValue,
    this.controller,
    this.focusNode,
  });
  final String? hintText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final bool readOnly;
  final bool autofocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSaved: onSaved,
        initialValue: initialValue,
        onTap: onTap,
        readOnly: readOnly,
        autofocus: autofocus,

        // Input decoration
        decoration: InputDecoration(
          // Border
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(14.r),
          ),

          // Enabled border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),

          // Property TextFormField
          filled: true,
          fillColor: AppColor.white.withAlpha(40),
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.0.h,
            horizontal: 10.0.w,
          ),
          hintText: hintText,
          hintStyle: AppFonts.medium_12.copyWith(
            color: AppColor.white.withAlpha(140),
          ),
          hintFadeDuration: Durations.extralong2,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
