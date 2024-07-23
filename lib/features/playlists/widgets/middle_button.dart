import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/alert_dialog/alert_dialog_body.dart';

class AddPlayListButtonMiddle extends StatefulWidget {
  const AddPlayListButtonMiddle({super.key});

  @override
  State<AddPlayListButtonMiddle> createState() =>
      _AddPlayListButtonMiddleState();
}

class _AddPlayListButtonMiddleState extends State<AddPlayListButtonMiddle> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Initialize controller with the default value
    _initializeController();

    // this to select text
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      }
    });
  }

  void _initializeController() {
    _controller = TextEditingController(text: "New playlist 1");
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomElvatedButton(
        widthButton: 160.w,
        onPressed: () async {
          final numberPlayList =
              context.read<PlaylistBloc>().state.playlist!.length;

          // Reset the controller's text to the initial value
          _controller.text = "New playlist ${numberPlayList + 1}";

          // Ensure the text selection works
          _focusNode.requestFocus();

          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialogBody(
                focusNode: _focusNode,
                controller: _controller,
              );
            },
          );
        },
        titleWithIcon: AppStrings.createPlaylist,
        icon: AppIcon.add,
        isIcon: true,
      ),
    );
  }
}
