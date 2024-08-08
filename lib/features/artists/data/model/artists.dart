import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Artist extends Equatable {
  final int id;
  final String artist;
  final int? numberOfAlbums;
  final int? numberOfTracks;

  const Artist(
      {required this.id,
      required this.artist,
      required this.numberOfAlbums,
      required this.numberOfTracks});

  factory Artist.fromDevice(ArtistModel artistsModel) {
    return Artist(
      id: artistsModel.id,
      artist: artistsModel.artist,
      numberOfAlbums: artistsModel.numberOfAlbums,
      numberOfTracks: artistsModel.numberOfTracks,
    );
  }

  @override
  List<Object?> get props => [id, artist, numberOfAlbums, numberOfTracks];
}
