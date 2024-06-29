import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppFonts {
  //==================== bold ============================
  static final TextStyle bold_18 =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  //==================== medium ============================
  static final TextStyle medium_12 =
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500);
  static final TextStyle medium_14 =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
  static final TextStyle medium_16 =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
  static final TextStyle medium_18 =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500);

  //==================== regular ============================
  static final TextStyle normal_8 =
      TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400);
  static final TextStyle normal_10 =
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400);
  static final TextStyle normal_12 =
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);
}
