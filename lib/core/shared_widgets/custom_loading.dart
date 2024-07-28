import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/utils/app_images.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.waveSoundAnimated,
        height: 22.h,
      ),
    );
  }
}
