import 'package:flutter/material.dart';
import 'package:just_music/core/utils/app_strings.dart';

class TitleAlertDialog extends StatelessWidget {
  const TitleAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppStrings.playlistName,
      textAlign: TextAlign.center,
    );
  }
}
