part of 'favorite_songs_bloc.dart';

sealed class FavoriteSongsEvent extends Equatable {
  const FavoriteSongsEvent();

  @override
  List<Object> get props => [];
}

//*** Load Favorite Song*/
class LoadFavoriteSongs extends FavoriteSongsEvent {
  final FavoriteSong favoriteSong;

  const LoadFavoriteSongs({this.favoriteSong = const FavoriteSong()});
  @override
  List<Object> get props => [favoriteSong];
}

//*** Add Song To Favorite*/
class AddSongToFavorite extends FavoriteSongsEvent {
  final Song song;

  const AddSongToFavorite({required this.song});
  @override
  List<Object> get props => [song];
}

//*** Remove Song From Favorite*/
class RemoveSongFromFavorite extends FavoriteSongsEvent {
  final Song song;

  const RemoveSongFromFavorite({required this.song});
  @override
  List<Object> get props => [song];
}
