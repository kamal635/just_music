part of 'songs_artist_bloc.dart';

sealed class SongsArtistEvent extends Equatable {
  const SongsArtistEvent();

  @override
  List<Object> get props => [];
}

class LoadSongsArtistByIdEvent extends SongsArtistEvent {
  final int artistId;
  const LoadSongsArtistByIdEvent({required this.artistId});

  @override
  List<Object> get props => [artistId];
}
