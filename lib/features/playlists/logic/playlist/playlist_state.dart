part of 'playlist_bloc.dart';

enum PlaylistStatus { initial, loading, loaded, failure }

class PlaylistState extends Equatable {
  final List<Playlist>? playlist;
  final PlaylistStatus playlistStatus;

  const PlaylistState({
    this.playlist,
    this.playlistStatus = PlaylistStatus.initial,
  });

  PlaylistState copyWith({
    List<Playlist>? playlist,
    PlaylistStatus? playlistStatus,
  }) {
    return PlaylistState(
      playlist: playlist ?? this.playlist,
      playlistStatus: playlistStatus ?? this.playlistStatus,
    );
  }

  @override
  List<Object?> get props => [playlist, playlistStatus];
}
