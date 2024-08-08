part of 'artists_bloc.dart';

sealed class ArtistsEvent extends Equatable {
  const ArtistsEvent();

  @override
  List<Object> get props => [];
}

class LoadArtistEvent extends ArtistsEvent {}
