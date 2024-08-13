part of 'artists_bloc.dart';

enum ArtistsStatus { initial, loading, loaded, failure }

class ArtistsState extends Equatable {
  final ArtistsStatus artistsStatus;
  final List<Artist> artists;

  const ArtistsState({
    this.artistsStatus = ArtistsStatus.initial,
    this.artists = const <Artist>[],
  });

  ArtistsState copyWith({
    final ArtistsStatus? artistsStatus,
    final List<Artist>? artists,
  }) {
    return ArtistsState(
      artistsStatus: artistsStatus ?? this.artistsStatus,
      artists: artists ?? this.artists,
    );
  }

  @override
  List<Object?> get props => [artistsStatus, artists];
}
