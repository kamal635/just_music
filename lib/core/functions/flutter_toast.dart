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
Future<void> toastShuffleMode(bool enabled) async {
  await flutterToast(
    message: enabled ? "SHUFFLE ON" : "SHUFFLE OFF",
    position: ToastGravity.TOP,
    time: 1,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: enabled ? AppColor.white : AppColor.white.withAlpha(80),
    textColor: enabled ? AppColor.black : AppColor.white,
  );
}

//**************** Custom Flutter Toast For Repeat Mode *****************/
//**** I explained how repeat all and one works in method (excuteEventRepeatMode) */
void toastRepeatMode(bool repeateAll, bool repeateOne) {
  flutterToast(
    message: repeateAll
        ? "REPEAT OFF"
        : repeateOne
            ? "REPEAT ALL"
            : "REPEAT ONE",
    position: ToastGravity.TOP,
    time: 1,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: AppColor.white,
    textColor: AppColor.black,
  );
}
