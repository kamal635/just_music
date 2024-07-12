import 'package:equatable/equatable.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class FavoriteSong extends Equatable {
  final List<Song> favoriteSongs;

  const FavoriteSong({this.favoriteSongs = const <Song>[]});

  @override
  List<Object?> get props => [favoriteSongs];
}
