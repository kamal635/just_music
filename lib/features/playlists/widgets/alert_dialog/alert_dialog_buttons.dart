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

class ButtonsAlertDialog extends StatelessWidget {
  const ButtonsAlertDialog({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //   Cancel
        CustomElvatedButton(
          widthButton: 100.w,
          onPressed: () {
            context.pop();
          },
          title: AppStrings.cancel,
          colorButton: AppColor.white.withAlpha(80),
        ),

        //  OK
        BlocBuilder<PlaylistBloc, PlaylistState>(
          builder: (context, state) {
            final isNameExisting = state.playlist?.any(
                  (pl) => pl.name == controller.text,
                ) ??
                false;
            return CustomElvatedButton(
              widthButton: 100.w,
              onPressed: () {
                if (controller.text == "") {
                  flutterToast(
                      context: context,
                      message: AppStrings.nameBlank,
                      gravity: ToastGravity.TOP);
                } else if (!isNameExisting) {
                  flutterToast(
                      context: context,
                      message: "Name Playlist already exist",
                      gravity: ToastGravity.TOP);
                } else {
                  // add the text and vlaue to create playlist
                  context
                      .read<PlaylistBloc>()
                      .add(CreatePlaylist(name: controller.text));
                  context.pop();
                }
              },
              title: AppStrings.ok,
              colorButton: AppColor.primary,
            );
          },
        ),
      ],
    );
  }
}
