import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_music/core/styling/app_colors.dart';

//******************* Primary Flutter Toast*******************/
Future<void> flutterToast({
  required String message,
  Color? backgroundColor,
  Color? textColor,
  ToastGravity? position,
  int? time,
  Toast? toastLength,
}) async {
  await Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength ?? Toast.LENGTH_LONG,
      gravity: position ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: time ?? 2,
      backgroundColor: backgroundColor ?? Colors.orange,
      textColor: textColor ?? Colors.white,
      fontSize: 14.sp);
}

//**************** Custom Flutter Toast For Shuffle Mode *****************/
Future<void> toastShuffleMode(
    bool enabled, AudioServiceShuffleMode? shuffleMode) async {
  await flutterToast(
    message: enabled ? "SHUFFLE ON" : "SHUFFLE OFF",
    position: ToastGravity.BOTTOM,
    time: 10,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: AppColor.white,
    textColor: AppColor.primary,
  );

  if (shuffleMode == AudioServiceShuffleMode.none ||
      shuffleMode == AudioServiceShuffleMode.all) {
    Future.delayed(const Duration(milliseconds: 400), () {
      Fluttertoast.cancel();
    });
  }
}

//**************** Custom Flutter Toast For Repeat Mode *****************/
//**** I explained how repeat all and one works in method (excuteEventRepeatMode) */
void toastRepeatMode(
    bool repeateAll, bool repeateOne, AudioServiceRepeatMode? repeatMode) {
  flutterToast(
    message: repeateAll
        ? "REPEAT OFF"
        : repeateOne
            ? "REPEAT ALL"
            : "REPEAT ONE",
    position: ToastGravity.BOTTOM,
    time: 0,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: AppColor.white,
    textColor: AppColor.primary,
  );

  if (repeatMode == AudioServiceRepeatMode.none ||
      repeatMode == AudioServiceRepeatMode.all ||
      repeatMode == AudioServiceRepeatMode.one) {
    Future.delayed(const Duration(milliseconds: 400), () {
      Fluttertoast.cancel();
    });
  }
}
