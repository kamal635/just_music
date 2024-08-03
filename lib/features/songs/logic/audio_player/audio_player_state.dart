part of 'audio_player_bloc.dart';

enum AudioPlayerStatus {
  initial,
  loaded,
  playing,
  paused,
  shuffle,
  repeate,
}

class AudioPlayerState extends Equatable {
  final AudioPlayerStatus status;
  final AudioPlayerData<Song>? audioPlayerData;
  final List<Song> recentlyPlayed;
  final List<MostPlayedModel> mostPlayed;

  const AudioPlayerState({
    this.status = AudioPlayerStatus.initial,
    this.audioPlayerData,
    this.recentlyPlayed = const [],
    this.mostPlayed = const [],
  });

  AudioPlayerState copyWith({
    AudioPlayerStatus? status,
    AudioPlayerData<Song>? audioPlayerData,
    List<Song>? recentlyPlayed,
    List<MostPlayedModel>? mostPlayed,
  }) {
    return AudioPlayerState(
      status: status ?? this.status,
      audioPlayerData: audioPlayerData ?? this.audioPlayerData,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      mostPlayed: mostPlayed ?? this.mostPlayed,
    );
  }

  @override
  List<Object?> get props =>
      [status, audioPlayerData, recentlyPlayed, mostPlayed];
}
