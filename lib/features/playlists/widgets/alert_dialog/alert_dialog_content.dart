import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_text_form_field.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';

class ContentAlertDialog extends StatelessWidget {
  const ContentAlertDialog(
      {super.key, required this.focusNode, required this.controller});
  final FocusNode focusNode;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // subtitle
        Text(
          AppStrings.enterPlaylistName,
          style: AppFonts.medium_12,
        ),

        spaceHeight(10),

        // TextFormField
        SizedBox(
          width: 220.w,
          child: CustomTextFormField(
            autofocus: true,
            focusNode: focusNode,
            controller: controller,
            onChanged: (value) {
              // get number of list playlist
              final numberPlayList =
                  context.read<PlaylistBloc>().state.playlist!.length;

              // Reset the controller's text to the initial value
              controller.text = "New playlist ${numberPlayList + 1}";

              // Assign the controller to the value
              controller.text = value;
            },
          ),
        )
      ],
    );
  }
}
