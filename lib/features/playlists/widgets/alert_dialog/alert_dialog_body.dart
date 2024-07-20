import 'package:flutter/material.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/features/playlists/widgets/alert_dialog/alert_dialog_buttons.dart';
import 'package:just_music/features/playlists/widgets/alert_dialog/alert_dialog_content.dart';
import 'package:just_music/features/playlists/widgets/alert_dialog/alert_dialog_title.dart';

class AlertDialogBody extends StatelessWidget {
  const AlertDialogBody(
      {super.key, required this.focusNode, required this.controller});
  final FocusNode focusNode;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Title
      title: const TitleAlertDialog(),
      titleTextStyle: AppFonts.medium_18,

      // backgroundColor dialog
      backgroundColor: AppColor.secondary,

      // content (subtitle + textformfield)
      content: ContentAlertDialog(focusNode: focusNode, controller: controller),

      // actions : buttons
      actions: [
        ButtonsAlertDialog(controller: controller),
      ],
    );
  }
}
