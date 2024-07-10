import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';

// Handle the current toast reference
FToast? _currentToast;

//******************* Primary Flutter Toast ********************/
Future<void> flutterToast(
    {required BuildContext context, required String message}) async {
  // Cancel the current toast if it exists
  _currentToast?.removeCustomToast();

  // Show the new toast
  _currentToast = FToast();
  _currentToast!.init(context);
  _currentToast!.showToast(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.primary,
      ),
      child: Text(message,
          style: AppFonts.normal_12.copyWith(color: AppColor.white)),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 1),
  );
}

//**************** Custom Flutter Toast For Shuffle Mode *****************/
Future<void> toastShuffleMode(
    {required bool enabled,
    required AudioServiceShuffleMode? shuffleMode,
    required BuildContext context}) async {
  // Cancel the current toast if it exists
  _currentToast?.removeCustomToast();

  // Show the new toast
  _currentToast = FToast();
  _currentToast!.init(context);
  _currentToast!.showToast(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.primary,
      ),
      child: Text(enabled ? "SHUFFLE ON" : "SHUFFLE OFF",
          style: AppFonts.normal_12.copyWith(color: AppColor.white)),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 1),
  );
}

//**************** Custom Flutter Toast For Repeat Mode *****************/
//**** I explained how repeat all and one works in method (excuteEventRepeatMode) */
Future<void> toastRepeatMode(
    {required bool repeateAll,
    required bool repeateOne,
    required BuildContext context}) async {
  // Cancel the current toast if it exists
  _currentToast?.removeCustomToast();

  // Show the new toast
  _currentToast = FToast();
  _currentToast!.init(context);
  _currentToast!.showToast(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.primary,
      ),
      child: Text(
          repeateAll
              ? "REPEAT OFF"
              : repeateOne
                  ? "REPEAT ALL"
                  : "REPEAT ONE",
          style: AppFonts.normal_12.copyWith(color: AppColor.white)),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 1),
  );
}

//**************** Custom Flutter Toast For Favorite *****************/
Future<void> toastFavorite(
    {required bool isFavorite, required BuildContext context}) async {
  // Cancel the current toast if it exists
  _currentToast?.removeCustomToast();

  // Show the new toast
  _currentToast = FToast();
  _currentToast!.init(context);
  _currentToast!.showToast(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.primary,
      ),
      child: Text(
          isFavorite ? "Removed from favorite song" : "Added to favorite song",
          style: AppFonts.normal_12.copyWith(color: AppColor.white)),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 1),
  );
}
