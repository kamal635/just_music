import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:just_music/features/songs/data/model/song.dart';

part 'most_played_model.g.dart';

@HiveType(typeId: 5) // Different typeId for Hive storage
class MostPlayedModel extends Equatable {
  @HiveField(0)
  final Song song;
  @HiveField(1)
  final int playCount;

  const MostPlayedModel({
    required this.song,
    this.playCount = 0,
  });

  MostPlayedModel copyWith({
    Song? song,
    int? playCount,
  }) {
    return MostPlayedModel(
      song: song ?? this.song,
      playCount: playCount ?? this.playCount,
    );
  }

  @override
  List<Object?> get props => [song, playCount];
}
