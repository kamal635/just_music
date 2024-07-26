import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/song_menu_button/abstract_class_actions_song_menu.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/create_playlist_button.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/card_add_songs_to_playlist.dart';
import 'package:just_music/features/songs/data/model/song.dart';

//************** Add To Playlist Action  */
class AddToPlaylistAction implements SongMenuAction {
  final Playlist playlist;
  final Song song;

  AddToPlaylistAction(this.playlist, this.song);

  @override
  void execute(BuildContext context) {
    context.pop();
    showModalBottomSheet(
      backgroundColor: AppColor.primary,
      context: context,
      builder: (context) {
        return AddToPlaylistDialog(playlist: playlist, song: song);
      },
    );
  }
}

//***********************Add ToPlay list Dialog */
class AddToPlaylistDialog extends StatefulWidget {
  final Playlist playlist;
  final Song song;

  const AddToPlaylistDialog(
      {Key? key, required this.playlist, required this.song})
      : super(key: key);

  @override
  State<AddToPlaylistDialog> createState() => _AddToPlaylistDialogState();
}

class _AddToPlaylistDialogState extends State<AddToPlaylistDialog> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
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
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            sliverPadding(25),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Title Modal Bottom Sheet
                  Text(
                    AppStrings.addToPlaylist,
                    style: AppFonts.medium_16,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  spaceHeight(10),

                  // Button Create New Playlist
                  const CreatePlaylistButton(
                    isMiddleButton: false,
                    isTopRightButton: false,
                  ),
                ],
              ),
            ),
            sliverPadding(10),

            // List of playlists
            SliverList.builder(
              itemCount: state.playlist!.length,
              itemBuilder: (context, index) {
                // check if song exist
                final isSongExist = state.playlist![index].songs
                        ?.any((sg) => sg.id == widget.song.id) ??
                    false;

                // hide playlist I come from it
                if (widget.playlist.id != state.playlist![index].id) {
                  return InkWell(
                    onTap: () {
                      if (isSongExist) {
                        // Song Already exists
                        flutterToastError(
                          context: context,
                          message: AppStrings.songAlreadyExist,
                          gravity: ToastGravity.TOP,
                        );
                      } else {
                        // song successfully added
                        context.read<PlaylistBloc>().add(AddSongToPlaylist(
                            playlistId: state.playlist![index].id!,
                            song: widget.song));

                        flutterToastSuccessfully(
                            context: context,
                            message: AppStrings.successfullyAddedSong,
                            gravity: ToastGravity.TOP);
                      }
                    },
                    child: CustomCardAddSongToPlaylist(
                      title: state.playlist![index].name,
                      index: index,
                      subtitle: state.playlist![index].songs!.length,
                      isArtwork: true,
                      artworkId: state.playlist![index].songs == null ||
                              state.playlist![index].songs!.isEmpty
                          ? -1
                          : state.playlist![index].songs?.first.id ?? -1,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            sliverPadding(25),
          ],
        );
      },
    );
  }
}
