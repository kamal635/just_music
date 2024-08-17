import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/constant/app_icon.dart';
import 'package:just_music/core/constant/app_strings.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: AppColor.secondary,
      iconColor: AppColor.white,
      icon: const Icon(AppIcon.settings),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onSelected: (int result) {
        switch (result) {
          //* Case 0 : go to privacy site
          case 0:
            _launchUrl(AppLinksUrl.privacy);
          //* Case 1 : go to terms of use
          case 1:
            _launchUrl(AppLinksUrl.terms);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        /// Edit Playlist Info
        PopupMenuItem<int>(
          value: 0,
          child: Text(
            AppStrings.privacy,
            style: AppFonts.medium_12,
          ),
        ),

        /// Divider
        PopupMenuItem<int>(
          height: 0,
          value: 0,
          child: Divider(
            color: AppColor.white.withAlpha(110),
            thickness: 0.5,
          ),
        ),

        /// Delete
        PopupMenuItem<int>(
          value: 1,
          child: Text(
            AppStrings.terms,
            style: AppFonts.medium_12,
          ),
        ),
      ],
    );
  }
}
