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
  late bool isNameExisting;

  @override
  void initState() {
    super.initState();
    isNameExisting = false;

    // Add listener to the TextEditingController
    widget.controller.addListener(_checkNameExistence);
  }

  @override
  void dispose() {
    // Remove listener when the widget is disposed
    widget.controller.removeListener(_checkNameExistence);
    super.dispose();
  }

  void _checkNameExistence() {
    final state = context.read<PlaylistBloc>().state;
    final newName = widget.controller.text;
    final nameExists = state.playlist?.any((pl) => pl.name == newName) ?? false;

    if (isNameExisting != nameExists) {
      setState(() {
        isNameExisting = nameExists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
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
                // if text is empty
                if (widget.controller.text.isEmpty) {
                  flutterToastError(
                      context: context,
                      message: AppStrings.nameBlank,
                      gravity: ToastGravity.TOP);
                } // if playlist name is already exist
                else if (isNameExisting) {
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
      },
    );
  }
}
