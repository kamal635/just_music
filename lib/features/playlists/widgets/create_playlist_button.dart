import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/alert_dialog/alert_dialog_body.dart';

class CreatePlaylistButton extends StatefulWidget {
  const CreatePlaylistButton(
      {super.key,
      required this.isMiddleButton,
      required this.isTopRightButton});
  final bool isMiddleButton;
  final bool isTopRightButton;
  @override
  State<CreatePlaylistButton> createState() => _CreatePlaylistButtonState();
}

class _CreatePlaylistButtonState extends State<CreatePlaylistButton> {
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
    return
        // is middle button == true => elvated button
        widget.isMiddleButton
            ? CustomElvatedButton(
                widthButton: 160.w,
                onPressed: () async {
                  // show alert dialog to create playlist
                  await showDialogCreatePlaylist(context);
                },
                titleWithIcon: AppStrings.createPlaylist,
                icon: AppIcon.add,
                isIcon: true,
              )
            : widget.isTopRightButton
                ?
                // is Top Right button == true => icon button
                Align(
                    alignment: Alignment.topRight,
                    child: CustomIconButton(
                      onPressed: () async {
                        // Show alert dialog to create playlist
                      },
                      icon: AppIcon.addMusicOrPlaylist,
                    ),
                  )

                // is middle button == false && top right button == false => container add new playlist
                : InkWell(
                    onTap: () async {
                      await showDialogCreatePlaylist(context);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColor.white.withAlpha(140),
                          ),
                          child: Icon(
                            AppIcon.add,
                            color: AppColor.primary,
                            size: 22.h,
                          ),
                        ),
                        Text(
                          AppStrings.newPlaylist,
                          style: AppFonts.medium_12,
                        )
                      ],
                    ),
                  );
  }

  Future<void> showDialogCreatePlaylist(BuildContext context) async {
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
          focusNode: _focusNode,
          controller: _controller,
        );
      },
    );
  }
}
