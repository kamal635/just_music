import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:just_music/features/home/data/repository/audio_player_data.dart';
import 'package:rxdart/rxdart.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioHandler _audioHandler;
  AudioPlayerBloc({
    required AudioHandler audioHandler,
  })  : _audioHandler = audioHandler,
        super(const AudioPlayerState()) {
    on<LoadAudioPlayerEvent>(
        _onLoadAudioPlayer); //combine streams and load audio player to check if song is null or not

    on<PlayAudioEvent>(_onPlayAudio); // play song

    on<PauseAudioEvent>(_onPauseAudio); // pause song

    on<SetAudioEvent>(
        _onSetAudio); // set list of songs and mapping to media item

    on<SeekToPositionAudioEvent>(
        _onSeekToPositionAudioEvent); // Change the position of the song when the user slides his finger on the slider

    on<SkipToNextAudioEvent>(_onSkipToNextAudioEvent); // to skip to next song

    on<SkipToPreviousAudioEvent>(
        _onSkipToPreviousAudioEvent); // to skip to previous song
  }

  ///**********************Load Audio Player*****************************/
  ///***************************************************/
  void _onLoadAudioPlayer(
    LoadAudioPlayerEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    // combine 4 streams to output   AudioPlayerData<Song>
    Stream<AudioPlayerData<Song>> audioPlayerDataStream = Rx.combineLatest4<
        PlaybackState,
        List<MediaItem>,
        MediaItem?,
        Duration,
        AudioPlayerData<Song>>(
      _audioHandler.playbackState,
      _audioHandler.queue,
      _audioHandler.mediaItem,
      AudioService.position,
      (playbackState, mediaItems, mediaItem, position) {
        // can be "null" if there not any song playing in the player
        final audio =
            (mediaItem == null) ? null : Song.fromMediaItem(mediaItem);

        final queue = mediaItems.map((e) => Song.fromMediaItem(e)).toList();

        return AudioPlayerData<Song>(
          audio: audio,
          queue: queue,
          playbackState: playbackState,
          currentAudioDuration: audio?.duration,
          currentAudioPosition: position,
        );
      },
    );

    await emit.forEach(
      audioPlayerDataStream,
      onData: (data) {
        // in this case we don't  display "music track player card"
        if (state.status == AudioPlayerStatus.initial && data.audio == null) {
          return state.copyWith(
            audioPlayerData: data,
            status: AudioPlayerStatus.initial,
          );
        }

        // in this case we  display "music track player card"
        if (state.status == AudioPlayerStatus.initial && data.audio != null) {
          return state.copyWith(
            audioPlayerData: data,
            status: AudioPlayerStatus.loaded,
          );
        }

        debugPrint('data: ${data.playbackState.toString()}');
        return state.copyWith(audioPlayerData: data);
      },
    );
  }

  ///***********************Play Audio****************************/
  ///***************************************************/
  void _onPlayAudio(
    PlayAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.play();
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///***********************Pause Audio****************************/
  ///***************************************************/
  void _onPauseAudio(
    PauseAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.pause();
    emit(state.copyWith(status: AudioPlayerStatus.paused));
  }

  ///**********************Seek To Position Audio*****************************/
  ///***************************************************/
  void _onSeekToPositionAudioEvent(
    SeekToPositionAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.seek(event.position);
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///**********************Skip To Next Song*****************************/
  ///***************************************************/
  void _onSkipToNextAudioEvent(
    SkipToNextAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.skipToNext();
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///***********************Skip To Previous Song****************************/
  ///***************************************************/
  void _onSkipToPreviousAudioEvent(
    SkipToPreviousAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.skipToPrevious();
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///***********************Set Audio****************************/
  ///***************************************************/
  void _onSetAudio(
    SetAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    // Clear list of media items to avoid repeating songs within the list
    _audioHandler.queue.value.clear();

    // maping on list of songs for push each song to media item
    List<MediaItem> mediaItems =
        event.songs.map((song) => song.toMediaItem()).toList();

    // then add list of media items here
    await _audioHandler.addQueueItems(mediaItems);

    // this to play song by index when user press on song in listview.builder
    await _audioHandler.skipToQueueItem(event.index);

    //  play song
    await _audioHandler.play();

    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }
}
