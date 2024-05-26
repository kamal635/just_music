import 'package:flutter/material.dart';
import 'package:just_music/core/styling/icons.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';

class SectionDoubleButton extends StatelessWidget {
  const SectionDoubleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElvatedButton(
          icon: AppIcon.play,
          title: "Play All",
          onPressed: () {},
        ),
        CustomElvatedButton(
          icon: AppIcon.shuffle,
          title: "Shuffle",
          onPressed: () {},
        ),
      ],
    );
  }
}