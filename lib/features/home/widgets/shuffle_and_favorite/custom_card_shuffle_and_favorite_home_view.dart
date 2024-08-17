import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/styling/app_fonts.dart';
import '../../../../core/constant/app_icon.dart';
import '../../../../core/constant/app_strings.dart';

class CustomCardShuffleAndFavoriteHomeView extends StatelessWidget {
  const CustomCardShuffleAndFavoriteHomeView(
      {super.key, required this.isFavorite, required this.onTap});
  final bool isFavorite;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: isFavorite
                ? AppColor.favorite.withAlpha(80)
                : AppColor.lightBlue.withAlpha(80),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                isFavorite ? AppIcon.favoriteFilled : AppIcon.shuffle,
                size: 22.h,
                color: isFavorite ? AppColor.favorite : AppColor.lightBlue,
              ),
              Text(
                isFavorite ? AppStrings.favorite : AppStrings.shuffle,
                style: AppFonts.medium_16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
