import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/song_menu_button/abstract_class_actions_song_menu.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class AddToFavoriteAction implements SongMenuAction {
  final Song song;
  final bool isFavorite;

  AddToFavoriteAction(this.song, this.isFavorite);

  @override
  void execute(BuildContext context) {
    final bloc = context.read<FavoriteSongsBloc>();
    if (isFavorite) {
      // isFavorite == true => remove
      bloc.add(RemoveSongFromFavorite(song: song));
      toastFavorite(isFavorite: isFavorite, context: context);
      context.pop();
    } else {
      // isFavorite == false => add
      bloc.add(AddSongToFavorite(song: song));
      toastFavorite(isFavorite: isFavorite, context: context);
      context.pop();
    }
  }
}
