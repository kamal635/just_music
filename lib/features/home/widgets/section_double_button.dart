import 'package:flutter/material.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/utils/app_strings.dart';

class SectionDoubleButton extends StatelessWidget {
  const SectionDoubleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElvatedButton(
          icon: AppIcon.play,
          titleWithIcon: AppStrings.playAll,
          onPressed: () {},
        ),
        CustomElvatedButton(
          icon: AppIcon.shuffle,
          titleWithIcon: AppStrings.shuffle,
          onPressed: () {},
        ),
      ],
    );
  }
}
