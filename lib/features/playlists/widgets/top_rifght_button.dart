import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/alert_dialog/alert_dialog_body.dart';

class AddPlayListButtonTopRight extends StatefulWidget {
  const AddPlayListButtonTopRight({super.key});

  @override
  State<AddPlayListButtonTopRight> createState() =>
      _AddPlayListButtonTopRightState();
}

class _AddPlayListButtonTopRightState extends State<AddPlayListButtonTopRight> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // init TextEditingController
    _controller = TextEditingController();

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

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CustomIconButton(
        onPressed: () async {
          // get number of list playlist
          final listOfPlayList = context.read<PlaylistBloc>().state.playlist;
          final numberPlayList = listOfPlayList!.length;

          // Reset the controller's text to the initial value and increse the value
          _controller.text = "New playlist ${numberPlayList + 1}";

          // Ensure the text selection works
          _focusNode.requestFocus();

          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialogBody(
                  focusNode: _focusNode, controller: _controller);
            },
          );
        },
        icon: AppIcon.addMusicOrPlaylist,
      ),
    );
  }
}
