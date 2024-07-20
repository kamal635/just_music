part of 'playlist_bloc.dart';

sealed class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object> get props => [];
}

//* Fetch Playlists
class LoadPlaylists extends PlaylistEvent {}

//* Create Playlist
class CreatePlaylist extends PlaylistEvent {
  final String name;

  const CreatePlaylist({required this.name});
  @override
  List<Object> get props => [name];
}

//* Add Song To Playlist
class AddSongToPlaylist extends PlaylistEvent {
  final String playlistId;
  final Song song;

  const AddSongToPlaylist({required this.playlistId, required this.song});
  @override
  List<Object> get props => [playlistId, song];
}

//* Sort By Date Created Or Modified
class SortByDateCreatedOrModified extends PlaylistEvent {}
