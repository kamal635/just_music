import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/shared_widgets/custom_text_form_field.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';

class ActionButtonAppBarPlaylistSongs extends StatelessWidget {
  const ActionButtonAppBarPlaylistSongs({super.key, required this.playlist});
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        // Find the updated playlist from the state
        final updatedPlaylist = state.playlist!
            .firstWhere((pl) => pl.id == playlist.id, orElse: () => playlist);

        // store name playlist to rename it
        String namePlaylist = updatedPlaylist.name;

        return PopupMenuButton<int>(
          color: AppColor.secondary,
          iconColor: AppColor.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          onSelected: (int result) {
            switch (result) {
              //* Case 0 : Edit Name Playlist
              case 0:
                showModalBottomSheet(
                  backgroundColor: AppColor.primary,
                  context: context,
                  builder: (context) {
                    return BlocBuilder<PlaylistBloc, PlaylistState>(
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            children: [
                              spaceHeight(20),

                              // title showModalBottomSheet
                              Text(
                                AppStrings.renamePlaylist,
                                style: AppFonts.medium_14,
                              ),

                              spaceHeight(20),

                              // Textformfield
                              CustomTextFormField(
                                autofocus: true,
                                initialValue: namePlaylist,
                                onChanged: (value) {
                                  namePlaylist = value;
                                },
                              ),

                              spaceHeight(20),

                              // Confirm Button
                              CustomElvatedButton(
                                onPressed: () {
                                  // check if playlist name is existing
                                  final isNameExisting = state.playlist?.any(
                                        (pl) => pl.name == namePlaylist,
                                      ) ??
                                      false;

                                  // if text is empty
                                  if (namePlaylist.isEmpty) {
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
                                    context.read<PlaylistBloc>().add(
                                        RenamePlaylist(
                                            name: namePlaylist,
                                            id: updatedPlaylist.id!));
                                    context.pop();
                                  }
                                },
                                title: AppStrings.confirm,
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              //* Case 0 : delete playlist
              case 1:
                context
                    .read<PlaylistBloc>()
                    .add(RemovePlaylist(id: updatedPlaylist.id!));
                context.pop();
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            /// Edit Playlist Info
            PopupMenuItem<int>(
              value: 0,
              child: Text(
                AppStrings.editNamePlaylist,
                style: AppFonts.medium_12,
              ),
            ),

            /// Divider
            PopupMenuItem<int>(
              height: 0,
              value: 0,
              child: Divider(
                color: AppColor.white.withAlpha(110),
                thickness: 0.5,
              ),
            ),

            /// Delete
            PopupMenuItem<int>(
              value: 1,
              child: Text(
                AppStrings.delete,
                style: AppFonts.medium_12,
              ),
            ),
          ],
        );
      },
    );
  }
}
