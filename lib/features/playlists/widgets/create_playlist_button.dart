import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/shared_widgets/custom_elvated_button.dart';
import '../../../core/shared_widgets/custom_icon_buttons.dart';
import '../../../core/styling/app_colors.dart';
import '../../../core/styling/app_fonts.dart';
import '../../../core/constant/app_icon.dart';
import '../../../core/constant/app_strings.dart';
import '../logic/playlist/playlist_bloc.dart';
import 'sub_widgets/alert_dialog/alert_dialog_body.dart';

class CreatePlaylistButton extends StatelessWidget {
  const CreatePlaylistButton({
    Key? key,
    required this.isMiddleButton,
    required this.isTopRightButton,
  }) : super(key: key);

  final bool isMiddleButton;
  final bool isTopRightButton;

  Future<void> showDialogCreatePlaylist(BuildContext context) async {
    final playlistBloc = context.read<PlaylistBloc>();
    final listOfPlayList = playlistBloc.state.playlist ?? [];

    final playlistNumbers = listOfPlayList
        .where((playlist) => playlist.name.startsWith("New playlist "))
        .map((playlist) {
      final name = playlist.name;
      final numberStr = name.replaceFirst("New playlist ", "");
      return int.tryParse(numberStr) ?? 0;
    }).toList();

    int newPlaylistNumber = 1;
    while (playlistNumbers.contains(newPlaylistNumber)) {
      newPlaylistNumber++;
    }

    playlistBloc.controller.text = "New playlist $newPlaylistNumber";
    playlistBloc.focusNode.requestFocus();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialogBody(
          focusNode: playlistBloc.focusNode,
          controller: playlistBloc.controller,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isMiddleButton
        ? CustomElevatedButton(
            widthButton: 160.w,
            onPressed: () async {
              await showDialogCreatePlaylist(context);
            },
            titleWithIcon: AppStrings.createPlaylist,
            icon: AppIcon.add,
            isIcon: true,
          )
        : isTopRightButton
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
}
