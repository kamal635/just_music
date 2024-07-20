import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:uuid/uuid.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class Playlist extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int? numOfSongs;
  @HiveField(3)
  final List<Song>? songs;
  @HiveField(4)
  final DateTime? dateCreatedOrModified;

  Playlist({
    String? id,
    required this.name,
    int? numOfSongs,
    List<Song>? songs,
    DateTime? dateCreatedOrModified,
  })  : id = id ?? const Uuid().v4(),
        songs = songs ?? const <Song>[],
        numOfSongs = numOfSongs ?? songs?.length,
        dateCreatedOrModified = dateCreatedOrModified ?? DateTime.now();

  Playlist copyWith({
    String? name,
    List<Song>? songs,
    DateTime? dateCreatedOrModified,
    int? numOfSongs,
  }) {
    return Playlist(
      id: id,
      name: name ?? this.name,
      numOfSongs: numOfSongs ?? this.numOfSongs,
      songs: songs ?? this.songs,
      dateCreatedOrModified:
          dateCreatedOrModified ?? this.dateCreatedOrModified,
    );
  }

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, numOfSongs: $numOfSongs,  dateCreatedOrModified: $dateCreatedOrModified )';
  }

  @override
  List<Object?> get props =>
      [id, name, numOfSongs, songs, dateCreatedOrModified];
}
