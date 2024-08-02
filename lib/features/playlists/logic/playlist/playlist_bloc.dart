import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/data/repository/playlist_repo.dart';
import 'package:just_music/features/songs/data/model/song.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final PlaylistRepoImpl playlistRepoImpl;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  PlaylistBloc({required this.playlistRepoImpl})
      : super(const PlaylistState()) {
    _focusNode.addListener(_selectText);
    on<LoadPlaylists>(_onLoadPlaylists); // load playlist
    on<CreatePlaylist>(_onCreatePlaylist); // create playlist
    on<RemovePlaylist>(_onRemovePlaylist); // Remove Playlist
    on<RenamePlaylist>(_onRenamePlaylist); // Rename Playlist
    on<AddSongToPlaylist>(_onAddSongToPlaylist); // add song to playlist
    on<RemoveSongFromPlaylist>(
        _onRemoveSongFromPlaylist); // Remove song From playlist
    on<SortByDateCreatedOrModified>(
        _onSortBySortByDateCreatedOrModified); // Sort By Date Created Or Modified
  }

  void _selectText() {
    if (_focusNode.hasFocus) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    }
  }

  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;

  @override
  Future<void> close() {
    _focusNode.removeListener(_selectText);
    _controller.dispose();
    _focusNode.dispose();
    return super.close();
  }

  ///****************Load Playlists*******************/
  ///************************************************/
  void _onLoadPlaylists(
    LoadPlaylists event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(state.copyWith(playlistStatus: PlaylistStatus.loading));

    try {
      Box box = await playlistRepoImpl.openBox();
      // fetch all playlists
      List<Playlist> playlist =
          playlistRepoImpl.sortByDateCreatedOrModified(box);

      emit(state.copyWith(
        playlistStatus: PlaylistStatus.loaded,
        playlist: playlist,
      ));
    } catch (e) {
      emit(state.copyWith(playlistStatus: PlaylistStatus.failure));
    }
  }

  ///****************Create Playlist******************/
  ///************************************************/
  void _onCreatePlaylist(
    CreatePlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(state.copyWith(playlistStatus: PlaylistStatus.loading));

    try {
      Box box = await playlistRepoImpl.openBox();
      // create playlist
      playlistRepoImpl.createPlaylist(box, event.name);

      // update sort playlist by date added
      List<Playlist> updatedPlaylist =
          playlistRepoImpl.sortByDateCreatedOrModified(box);

      emit(state.copyWith(
          playlistStatus: PlaylistStatus.created, playlist: updatedPlaylist));
    } catch (e) {
      emit(state.copyWith(playlistStatus: PlaylistStatus.failure));
    }
  }

  ///****************Remove Playlist******************/
  ///************************************************/
  void _onRemovePlaylist(
    RemovePlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(state.copyWith(playlistStatus: PlaylistStatus.loading));

    try {
      Box box = await playlistRepoImpl.openBox();
      // create playlist
      playlistRepoImpl.removePlaylist(box, event.id);

      // update sort playlist by date added
      List<Playlist> updatedPlaylist =
          playlistRepoImpl.sortByDateCreatedOrModified(box);

      emit(state.copyWith(
          playlistStatus: PlaylistStatus.remove, playlist: updatedPlaylist));
    } catch (e) {
      emit(state.copyWith(playlistStatus: PlaylistStatus.failure));
    }
  }

  ///****************Rename Playlist******************/
  ///************************************************/
  void _onRenamePlaylist(
    RenamePlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(state.copyWith(playlistStatus: PlaylistStatus.loading));

    try {
      Box box = await playlistRepoImpl.openBox();
      // create playlist
      playlistRepoImpl.renamePlaylist(box, event.name, event.id);

      // update sort playlist by date added
      List<Playlist> updatedPlaylist =
          playlistRepoImpl.sortByDateCreatedOrModified(box);

      emit(state.copyWith(
          playlistStatus: PlaylistStatus.loaded, playlist: updatedPlaylist));
    } catch (e) {
      emit(state.copyWith(playlistStatus: PlaylistStatus.failure));
    }
  }

  ///**************Add Song To Playlist****************/
  ///************************************************/
  void _onAddSongToPlaylist(
    AddSongToPlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(state.copyWith(playlistStatus: PlaylistStatus.loading));

    try {
      Box box = await playlistRepoImpl.openBox();

      // add sont to playlist by playlist id
      playlistRepoImpl.addSongToPlaylist(box, event.playlistId, event.song);

      // update sort playlist by date modified
      List<Playlist> updatedPlaylist =
          playlistRepoImpl.sortByDateCreatedOrModified(box);

      emit(state.copyWith(
          playlistStatus: PlaylistStatus.loaded, playlist: updatedPlaylist));
    } catch (e) {
      emit(state.copyWith(playlistStatus: PlaylistStatus.failure));
    }
  }

  ///**************Remove Song From Playlist****************/
  ///************************************************/
  void _onRemoveSongFromPlaylist(
    RemoveSongFromPlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(state.copyWith(playlistStatus: PlaylistStatus.loading));

    try {
      Box box = await playlistRepoImpl.openBox();

      // remove song from playlist by playlist id
      playlistRepoImpl.removeSongFromPlaylist(
          box, event.playlistId, event.song);

      // update sort playlist by date modified
      List<Playlist> updatedPlaylist =
          playlistRepoImpl.sortByDateCreatedOrModified(box);

      emit(state.copyWith(
          playlistStatus: PlaylistStatus.loaded, playlist: updatedPlaylist));
    } catch (e) {
      emit(state.copyWith(playlistStatus: PlaylistStatus.failure));
    }
  }

  ///***********Sort By Date Created Or Modified**************/
  ///********************************************************/
  void _onSortBySortByDateCreatedOrModified(
    SortByDateCreatedOrModified event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(state.copyWith(playlistStatus: PlaylistStatus.loading));

    try {
      Box box = await playlistRepoImpl.openBox();
      final sortedPlaylists = playlistRepoImpl.sortByDateCreatedOrModified(box);

      emit(state.copyWith(
        playlistStatus: PlaylistStatus.loaded,
        playlist: sortedPlaylists,
      ));
    } catch (e) {
      emit(state.copyWith(playlistStatus: PlaylistStatus.failure));
    }
  }
}
