part of 'audio_player_bloc.dart';

enum AudioPlayerStatus {
  initial,
  loaded,
  playing,
  paused,
  shuffle,
  repeate,
}

class AudioPlayerState {
  final AudioPlayerData<Song>? audioPlayerData;
  final AudioPlayerStatus status;
  final List<Song> recentlyPlayed;
  final List<MostPlayedModel> mostPlayed;
  final Duration? lastKnownPosition;

  const AudioPlayerState({
    this.audioPlayerData,
    this.status = AudioPlayerStatus.initial,
    this.recentlyPlayed = const [],
    this.mostPlayed = const [],
    this.lastKnownPosition,
  });

  AudioPlayerState copyWith({
    AudioPlayerData<Song>? audioPlayerData,
    AudioPlayerStatus? status,
    List<Song>? recentlyPlayed,
    List<MostPlayedModel>? mostPlayed,
    Duration? lastKnownPosition,
  }) {
    return AudioPlayerState(
      audioPlayerData: audioPlayerData ?? this.audioPlayerData,
      status: status ?? this.status,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      mostPlayed: mostPlayed ?? this.mostPlayed,
      lastKnownPosition: lastKnownPosition ?? this.lastKnownPosition,
    );
  }
}
