import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox spaceHeight(double height) {
  return SizedBox(
    height: height.h,
  );
}

SizedBox spaceWidth(double width) {
  return SizedBox(
    width: width.w,
  );
}

SliverPadding paddingSliver(double heigh) {
  return SliverPadding(
    padding: EdgeInsets.only(top: heigh.h), // Adjust the padding as needed
  );
}
