import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Album extends Equatable {
  final int id;
  final int? artistId;
  final String album;
  final String? artist;
  final int? numOfSongs;

  const Album({
    required this.id,
    required this.artistId,
    required this.album,
    required this.artist,
    required this.numOfSongs,
  });

  factory Album.fromDevice(AlbumModel albumModel) {
    return Album(
      id: albumModel.id,
      artistId: albumModel.artistId,
      album: albumModel.album,
      artist: albumModel.artist,
      numOfSongs: albumModel.numOfSongs,
    );
  }

  @override
  List<Object?> get props => [id, artistId, album, artist, numOfSongs];
}
