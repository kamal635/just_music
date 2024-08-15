import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class AppIcon {
  //*******************Font Awesome Icons***********************/
  static const IconData favoriteBorder = FontAwesomeIcons.heart;
  static const IconData favoriteFilled = FontAwesomeIcons.solidHeart;
  static const IconData disc = FontAwesomeIcons.compactDisc;
  static const IconData home = FontAwesomeIcons.house;
  static const IconData shuffle = FontAwesomeIcons.shuffle;
  static const IconData headPhone = FontAwesomeIcons.headphones;

  //*******************Icons Material***********************/
  static const IconData playlist = Icons.library_music_outlined;
  static const IconData playlistFilled = Icons.library_music_sharp;

  static const IconData repateOne = Icons.repeat_one;
  static const IconData repateOff = Icons.repeat_outlined;

  static const IconData musicNote = Icons.music_note;

  static const IconData play = Icons.play_arrow;
  static const IconData pause = Icons.pause;

  static const IconData search = Icons.search;

  static const IconData threeDotVertical = Icons.more_vert;
  static const IconData menu = Icons.notes;

  static const IconData settings = Icons.settings;

  static const IconData checkMark = Icons.check;
  static const IconData warning = Icons.warning;

  static const IconData arrowBack = Icons.arrow_back_ios_new_outlined;
  static const IconData arrowForward = Icons.arrow_forward_ios_outlined;
  static const IconData arrowDown = Icons.arrow_downward_sharp;

  static const IconData add = Icons.add;
  static const IconData delete = Icons.delete;
  static const IconData rename = Icons.edit;
  static const IconData addMusicOrPlaylist = Icons.queue_outlined;
  static const IconData addToPlaylist = Icons.playlist_add;

  static const IconData detail = Icons.edit_document;

  static const IconData folder = Icons.folder;

  static const IconData skipNext = Icons.skip_next;
  static const IconData skipPrevious = Icons.skip_previous;
}
