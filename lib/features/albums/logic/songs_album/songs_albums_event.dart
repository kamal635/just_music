part of 'songs_albums_bloc.dart';

sealed class SongsAlbumsEvent extends Equatable {
  const SongsAlbumsEvent();

  @override
  List<Object> get props => [];
}

class LoadSongsAlbumByIdEvent extends SongsAlbumsEvent {
  final int albumId;
  const LoadSongsAlbumByIdEvent({required this.albumId});

  @override
  List<Object> get props => [albumId];
}
