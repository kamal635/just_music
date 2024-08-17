import 'package:flutter/material.dart';
import 'package:just_music/core/constant/app_icon.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';

class CustomIconBack extends StatelessWidget {
  const CustomIconBack({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () {
        context.pop();
      },
      icon: AppIcon.arrowBack,
    );
  }
}
