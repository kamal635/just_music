import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/alert_dialog/alert_dialog_body.dart';

class CreatePlaylistButton extends StatefulWidget {
  const CreatePlaylistButton({
    super.key,
    required this.isMiddleButton,
    required this.isTopRightButton,
  });
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
    _controller = TextEditingController();
    _focusNode.addListener(_selectText);
  }

  void _selectText() {
    if (mounted && _focusNode.hasFocus) {
      setState(() {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_selectText);
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isMiddleButton
        ? CustomElevatedButton(
            widthButton: 160.w,
            onPressed: () async {
              await showDialogCreatePlaylist(context);
            },
            titleWithIcon: AppStrings.createPlaylist,
            icon: AppIcon.add,
            isIcon: true,
          )
        : widget.isTopRightButton
            ? Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  onPressed: () async {
                    await showDialogCreatePlaylist(context);
                  },
                  icon: AppIcon.addMusicOrPlaylist,
                ),
              )
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
    final listOfPlayList = context.read<PlaylistBloc>().state.playlist;
    final numberPlayList = listOfPlayList?.length ?? 0;

    _controller.text = "New playlist ${numberPlayList + 1}";

    _focusNode.requestFocus();

    if (!mounted) return;

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
