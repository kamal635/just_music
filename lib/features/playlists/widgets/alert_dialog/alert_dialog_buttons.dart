import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          onPressed: () {
            context.pop();
          },
          title: AppStrings.cancel,
          color: AppColor.white.withAlpha(80),
        ),

        //  OK
        CustomElvatedButton(
          onPressed: () {
            // add the text and vlaue to create playlist
            context
                .read<PlaylistBloc>()
                .add(CreatePlaylist(name: controller.text));

            context.pop();
          },
          title: AppStrings.ok,
          color: AppColor.primary,
        ),
      ],
    );
  }
}
