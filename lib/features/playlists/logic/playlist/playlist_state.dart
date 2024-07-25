part of 'playlist_bloc.dart';

enum PlaylistStatus { initial, loading, loaded, failure }

class PlaylistState extends Equatable {
  final List<Playlist>? playlist;
  final PlaylistStatus playlistStatus;
  final String? errorMessage;

  const PlaylistState({
    this.playlist,
    this.playlistStatus = PlaylistStatus.initial,
    this.errorMessage,
  });

  PlaylistState copyWith({
    List<Playlist>? playlist,
    PlaylistStatus? playlistStatus,
    String? errorMessage,
  }) {
    return PlaylistState(
      playlist: playlist ?? this.playlist,
      playlistStatus: playlistStatus ?? this.playlistStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [playlist, playlistStatus];
}
