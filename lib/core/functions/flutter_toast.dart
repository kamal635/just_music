import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';

// Handle the current toast reference
FToast? _currentToast;

//*******************  Flutter Toast Successfully ********************/
Future<void> flutterToastSuccessfully({
  required BuildContext context,
  required String message,
  ToastGravity? gravity,
}) async {
  // Cancel the current toast if it exists
  _currentToast?.removeCustomToast();

  // Show the new toast
  _currentToast = FToast();
  _currentToast!.init(context);
  _currentToast!.showToast(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.white, width: 1),
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.secondary,
      ),
      child: Row(
        children: [
          Icon(
            AppIcon.checkMark,
            size: 18.h,
          ),
          spaceWidth(10),
          Text(message,
              style: AppFonts.normal_12.copyWith(color: AppColor.white)),
        ],
      ),
    ),
    gravity: gravity ?? ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}

//*******************  Flutter Toast Error********************/
Future<void> flutterToastError({
  required BuildContext context,
  required String message,
  ToastGravity? gravity,
}) async {
  // Cancel the current toast if it exists
  _currentToast?.removeCustomToast();

  // Show the new toast
  _currentToast = FToast();
  _currentToast!.init(context);
  _currentToast!.showToast(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.yellow, width: 1),
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.brown,
      ),
      child: Row(
        children: [
          Icon(
            AppIcon.warning,
            size: 18.h,
            color: AppColor.yellow,
          ),
          spaceWidth(10),
          Text(message,
              style: AppFonts.normal_12.copyWith(color: AppColor.white)),
        ],
      ),
    ),
    gravity: gravity ?? ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
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
        border: Border.all(color: AppColor.white, width: 1),
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.secondary,
      ),
      child: Text(enabled ? "SHUFFLE ON" : "SHUFFLE OFF",
          style: AppFonts.normal_12.copyWith(color: AppColor.white)),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
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
        border: Border.all(color: AppColor.white, width: 1),
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.secondary,
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
    toastDuration: const Duration(seconds: 2),
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
        border: Border.all(color: AppColor.white, width: 1),
        borderRadius: BorderRadius.circular(25.r),
        color: AppColor.secondary,
      ),
      child: Text(
          isFavorite ? "Removed from favorite song" : "Added to favorite song",
          style: AppFonts.normal_12.copyWith(color: AppColor.white)),
    ),
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 2),
  );
}
