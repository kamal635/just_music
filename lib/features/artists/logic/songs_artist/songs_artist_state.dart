part of 'songs_artist_bloc.dart';

enum SongsArtistStatus { initial, loading, loaded, failure }

class SongsArtistState extends Equatable {
  final SongsArtistStatus songsArtistStatus;
  final List<Song>? songs;

  const SongsArtistState({
    this.songsArtistStatus = SongsArtistStatus.initial,
    this.songs,
  });

  SongsArtistState copyWith({
    final SongsArtistStatus? songsArtistStatus,
    final List<Song>? songs,
  }) {
    return SongsArtistState(
      songsArtistStatus: songsArtistStatus ?? this.songsArtistStatus,
      songs: songs ?? this.songs,
    );
  }

  @override
  List<Object?> get props => [songsArtistStatus, songs];
}
