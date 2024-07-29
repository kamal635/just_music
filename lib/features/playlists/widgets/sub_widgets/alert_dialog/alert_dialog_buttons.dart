import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';

class ButtonsAlertDialog extends StatefulWidget {
  const ButtonsAlertDialog({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<ButtonsAlertDialog> createState() => _ButtonsAlertDialogState();
}

class _ButtonsAlertDialogState extends State<ButtonsAlertDialog> {
  bool isNameExisting = false;

  @override
  void initState() {
    super.initState();
    // Add a listener to update the state whenever the text changes
    widget.controller.addListener(_checkNameExistence);
  }

  void _checkNameExistence() {
    if (mounted) {
      setState(() {
        isNameExisting = context.read<PlaylistBloc>().state.playlist?.any((pl) {
              return widget.controller.text == pl.name;
            }) ??
            false;
      });
    }
  }

  @override
  void dispose() {
    // Remove listener before disposing of the controller
    widget.controller.removeListener(_checkNameExistence);
    print("TextEditingController listener removed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomElevatedButton(
          widthButton: 100.w,
          onPressed: () {
            context.pop();
          },
          title: AppStrings.cancel,
          colorButton: AppColor.white.withAlpha(80),
        ),
        CustomElevatedButton(
          widthButton: 100.w,
          onPressed: () {
            if (widget.controller.text.isEmpty) {
              flutterToastError(
                  context: context,
                  message: AppStrings.nameBlank,
                  gravity: ToastGravity.TOP);
            } else if (isNameExisting) {
              flutterToastError(
                  context: context,
                  message: AppStrings.nameAlreadyExist,
                  gravity: ToastGravity.TOP);
            } else {
              context
                  .read<PlaylistBloc>()
                  .add(CreatePlaylist(name: widget.controller.text));
              context.pop();
            }
          },
          title: AppStrings.ok,
          colorButton: AppColor.primary,
        ),
      ],
    );
  }
}
