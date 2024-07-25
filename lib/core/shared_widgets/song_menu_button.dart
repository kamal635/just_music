import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/favorites/data/models/favorite_model.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/alert_dialog/alert_dialog_body.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_songs/add_songs_to_playlist/card_add_songs_to_playlist.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class SongMenuButton extends StatelessWidget {
  const SongMenuButton({super.key, required this.playlist, required this.song});
  final Playlist playlist;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteSongsBloc, FavoriteSongsState>(
      builder: (context, state) {
        return CustomIconButton(
          onPressed: () {
            showModalBottomSheet(
              // to take showModalBottomSheet full height
              isScrollControlled: true,

              // color showModalBottomSheet
              backgroundColor: AppColor.primary,

              context: context,
              builder: (context) {
                return CustomScrollView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    sliverPadding(25),
                    SliverToBoxAdapter(
                      child: ListTile(
                        title: Text(
                          song.title,
                          style: AppFonts.medium_16,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          song.artist ?? "<Unknown>",
                          style: AppFonts.normal_12
                              .copyWith(color: AppColor.white.withAlpha(110)),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: SongMenuModel.listSongMenu(
                              song, state.favoriteSong, playlist)
                          .length,
                      itemBuilder: (context, index) {
                        final songMenuModel = SongMenuModel.listSongMenu(
                            song, state.favoriteSong, playlist)[index];
                        return InkWell(
                          onTap: () {
                            songMenuModel.action.execute(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(4.h),
                            child: ListTile(
                              leading: Container(
                                height: 28.h,
                                width: 28.h,
                                decoration: BoxDecoration(
                                    color: AppColor.secondary,
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: Icon(
                                  songMenuModel.icon,
                                  color: songMenuModel.colorIcon,
                                  size: 18.h,
                                ),
                              ),
                              title: Text(
                                songMenuModel.name,
                                style: AppFonts.medium_12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    sliverPadding(25),
                  ],
                );
              },
            );
          },
          icon: AppIcon.threeDotVertical,
        );
      },
    );
  }
}

class SongMenuModel {
  final IconData icon;
  final Color colorIcon;
  final String name;
  final SongMenuAction action;

  SongMenuModel({
    required this.icon,
    required this.name,
    required this.action,
    this.colorIcon = AppColor.white,
  });

  static List<SongMenuModel> listSongMenu(
      Song song, FavoriteSong? favoriteSong, Playlist playlist) {
    final isFavorite =
        favoriteSong?.favoriteSongs.any((s) => s.id == song.id) ?? false;
    return [
      SongMenuModel(
        icon: isFavorite ? AppIcon.favoriteFilled : AppIcon.favoriteBorder,
        colorIcon: isFavorite ? AppColor.red : AppColor.white,
        name: AppStrings.addToFavorite,
        action: AddToFavoriteAction(song, isFavorite),
      ),
      SongMenuModel(
        icon: AppIcon.addMusicOrPlaylist,
        name: AppStrings.addToPlaylist,
        action: AddToPlaylistAction(playlist, song),
      ),
      SongMenuModel(
        icon: AppIcon.delete,
        name: AppStrings.removeFromPlaylist,
        action: RemoveFromPlaylistAction(song, playlist),
      ),
      SongMenuModel(
        icon: AppIcon.rename,
        name: AppStrings.detail,
        action: DetailSongAction(song),
      ),
    ];
  }
}

abstract class SongMenuAction {
  void execute(BuildContext context);
}

class AddToFavoriteAction implements SongMenuAction {
  final Song song;
  final bool isFavorite;

  AddToFavoriteAction(this.song, this.isFavorite);

  @override
  void execute(BuildContext context) {
    final bloc = context.read<FavoriteSongsBloc>();
    if (isFavorite) {
      bloc.add(RemoveSongFromFavorite(song: song));
      toastFavorite(isFavorite: isFavorite, context: context);
      context.pop();
    } else {
      bloc.add(AddSongToFavorite(song: song));
      toastFavorite(isFavorite: isFavorite, context: context);
      context.pop();
    }
  }
}

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

class AddToPlaylistDialog extends StatefulWidget {
  final Playlist playlist;
  final Song song;

  const AddToPlaylistDialog(
      {Key? key, required this.playlist, required this.song})
      : super(key: key);

  @override
  _AddToPlaylistDialogState createState() => _AddToPlaylistDialogState();
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
                  ListTile(
                    title: Text(
                      AppStrings.addToPlaylist,
                      style: AppFonts.medium_16,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  spaceHeight(10),
                  InkWell(
                    onTap: () async {
                      // get number of list playlist
                      final listOfPlayList =
                          context.read<PlaylistBloc>().state.playlist;
                      final numberPlayList = listOfPlayList!.length;

                      // Reset the controller's text to the initial value and increase the value
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
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
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
                          "New Playlist",
                          style: AppFonts.medium_12,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            sliverPadding(10),
            SliverList.builder(
              itemCount: state.playlist!.length,
              itemBuilder: (context, index) {
                final isSongExist = state.playlist![index].songs
                        ?.any((sg) => sg.id == widget.song.id) ??
                    false;
                if (widget.playlist.id != state.playlist![index].id) {
                  return InkWell(
                    onTap: () {
                      if (isSongExist) {
                        flutterToastError(
                          context: context,
                          message: "This song already exists in this playlist",
                          gravity: ToastGravity.TOP,
                        );
                      } else {
                        context.read<PlaylistBloc>().add(AddSongToPlaylist(
                            playlistId: state.playlist![index].id!,
                            song: widget.song));

                        flutterToastSuccessfully(
                            context: context,
                            message: "Successfully added to the playlist",
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

class RemoveFromPlaylistAction implements SongMenuAction {
  final Song song;
  final Playlist playlist;
  RemoveFromPlaylistAction(this.song, this.playlist);

  @override
  void execute(BuildContext context) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(30.h),

          content: const Text(
            "Delete this song from the playlist?",
            textAlign: TextAlign.center,
          ),
          contentTextStyle: AppFonts.medium_16,
          // backgroundColor dialog
          backgroundColor: AppColor.secondary,

          // actions : buttons
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel
                CustomElvatedButton(
                  widthButton: 120.w,
                  onPressed: () {
                    context.pop();
                  },
                  title: AppStrings.cancel,
                  colorButton: AppColor.white.withAlpha(80),
                ),
                // OK
                CustomElvatedButton(
                  widthButton: 120.w,
                  onPressed: () {
                    context.read<PlaylistBloc>().add(RemoveSongFromPlaylist(
                        playlistId: playlist.id!, song: song));
                    context.pop();
                  },
                  title: AppStrings.confirm,
                  colorButton: AppColor.primary,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class DetailSongAction extends SongMenuAction {
  final Song song;

  DetailSongAction(this.song);

  @override
  void execute(BuildContext context) {
    context.pop();
    showModalBottomSheet(
      backgroundColor: AppColor.primary,
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to adjust its height
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            spaceHeight(20),
            Text(
              "detail",
              textAlign: TextAlign.center,
              style: AppFonts.medium_16,
            ),
            Container(
              // Set a minimum height if needed
              constraints: BoxConstraints(
                minHeight: 200.h, // Minimum height
              ),
              child: ListView.builder(
                shrinkWrap: true, // Shrink to fit content
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling
                itemCount: SongDetail.songDetail(song)
                    .length, // Replace with your item count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      constraints: BoxConstraints(minWidth: 50.w),
                      child: Text(
                        SongDetail.songDetail(song)[index].title,
                        style: AppFonts.medium_14
                            .copyWith(color: AppColor.white.withAlpha(160)),
                      ),
                    ),
                    title: Text(
                      textAlign: TextAlign.start,
                      SongDetail.songDetail(song)[index].subTitle,
                      style: AppFonts.normal_12.copyWith(color: AppColor.white),
                    ), // Replace with your song title
                  );
                },
              ),
            ),
            spaceHeight(20),
          ],
        );
      },
    );
  }
}

class SongDetail {
  final String title;
  final String subTitle;

  SongDetail({required this.title, required this.subTitle});

  static List<SongDetail> songDetail(Song song) {
    return [
      SongDetail(title: "Name", subTitle: song.title),
      SongDetail(title: "Artist", subTitle: song.artist ?? "<Unknown>"),
      SongDetail(title: "Size", subTitle: song.album ?? "<Unknown>"),
      SongDetail(title: "Format", subTitle: ".${song.fileExtension}"),
    ];
  }
}
