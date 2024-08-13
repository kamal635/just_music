part of 'songs_albums_bloc.dart';

enum SongsAlbumStatus { initial, loading, loaded, failure }

class SongsAlbumsState extends Equatable {
  final SongsAlbumStatus songsAlbumStatus;
  final List<Song>? songs;

  const SongsAlbumsState({
    this.songsAlbumStatus = SongsAlbumStatus.initial,
    this.songs,
  });

  SongsAlbumsState copyWith({
    final SongsAlbumStatus? songsAlbumStatus,
    final List<Song>? songs,
  }) {
    return SongsAlbumsState(
      songsAlbumStatus: songsAlbumStatus ?? this.songsAlbumStatus,
      songs: songs ?? this.songs,
    );
  }

  @override
  List<Object?> get props => [songsAlbumStatus, songs];
}
