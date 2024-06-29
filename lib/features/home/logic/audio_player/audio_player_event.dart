part of 'audio_player_bloc.dart';

sealed class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadAudioPlayerEvent extends AudioPlayerEvent {}

class PlayAudioEvent extends AudioPlayerEvent {}

class PauseAudioEvent extends AudioPlayerEvent {}

class SkipToNextAudioEvent extends AudioPlayerEvent {}

class SkipToPreviousAudioEvent extends AudioPlayerEvent {}

class SkipByIndexAudioEvent extends AudioPlayerEvent {
  final int index;

  const SkipByIndexAudioEvent({required this.index});
  @override
  List<Object> get props => [index];
}

class SeekToPositionAudioEvent extends AudioPlayerEvent {
  final Duration position;

  const SeekToPositionAudioEvent({required this.position});
  @override
  List<Object> get props => [position];
}

class SetAudioEvent extends AudioPlayerEvent {
  final List<Song> songs;
  final int index;

  const SetAudioEvent({required this.songs, required this.index});

  @override
  List<Object> get props => [songs, index];
}
