import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_music/features/home/data/most_played_repo.dart';
import 'package:just_music/features/home/data/recently_played_repo.dart';
import 'package:just_music/features/home/models/most_played_model.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/data/repository/audio_player_data.dart';
import 'package:rxdart/rxdart.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioHandler _audioHandler;
  final RecentlyPlayedRepoImpl recentlyPlayedRepoImpl;
  final MostPlayedRepoImpl mostPlayedRepoImpl;

  AudioPlayerBloc({
    required AudioHandler audioHandler,
    required this.recentlyPlayedRepoImpl,
    required this.mostPlayedRepoImpl,
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

    on<SkipByIndexAudioEvent>(_onSkipByIndexAudioEvent); // to skip by index

    on<ShuffleModeAudioEvent>(_onShuffleModeAudioEvent); // shuffle Mode

    on<RepeatModeAudioEvent>(_onRepeatModeAudioEvent); // Repeat Mode

    on<LoadRecentlyPlayedEvent>(_onLoadRecentlyPlayedEvent); // Recently Played

    on<MostPlayedEvent>(_onMostPlayedEvent); // Most Played
  }

  ///****************Load Audio Player*******************/
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

        // This listens for changes in the playback state of the audio handler
        _audioHandler.playbackState
            .debounceTime(const Duration(milliseconds: 500))
            .distinct((prev, next) =>
                prev.processingState == next.processingState &&
                prev.playing == next.playing)
            .listen((playbackState) {
          if (playbackState.processingState == AudioProcessingState.completed) {
            _addCurrentSongToRecentlyPlayed(emit);
            _addCurrentSongToMostPlayed(emit);
          }
        });

        debugPrint('data: ${data.playbackState.toString()}');
        return state.copyWith(audioPlayerData: data);
      },
    );
  }

  ///*******************Play Audio***********************/
  ///***************************************************/
  void _onPlayAudio(
    PlayAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.play();
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///*******************Pause Audio**********************/
  ///***************************************************/
  void _onPauseAudio(
    PauseAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.pause();
    emit(state.copyWith(status: AudioPlayerStatus.paused));
  }

  ///*************Seek To Position Audio*****************/
  ///***************************************************/
  void _onSeekToPositionAudioEvent(
    SeekToPositionAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.seek(event.position);
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///***************Skip To Next Song********************/
  ///***************************************************/
  void _onSkipToNextAudioEvent(
    SkipToNextAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.skipToNext();
    await _addCurrentSongToRecentlyPlayed(emit);
    await _addCurrentSongToMostPlayed(emit);
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///**************Skip To Previous Song*****************/
  ///***************************************************/
  void _onSkipToPreviousAudioEvent(
    SkipToPreviousAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.skipToPrevious();
    await _addCurrentSongToRecentlyPlayed(emit);
    await _addCurrentSongToMostPlayed(emit);
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///*******************Skip by index********************/
  ///***************************************************/
  void _onSkipByIndexAudioEvent(
    SkipByIndexAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.skipToQueueItem(event.index);
    await _addCurrentSongToRecentlyPlayed(emit);
    await _addCurrentSongToMostPlayed(emit);
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///********************Shuffle Mode********************/
  ///***************************************************/
  void _onShuffleModeAudioEvent(
    ShuffleModeAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.setShuffleMode(event.shuffleMode);
    emit(state.copyWith(status: AudioPlayerStatus.shuffle));
  }

  ///********************Repeate Mode********************/
  ///***************************************************/
  void _onRepeatModeAudioEvent(
    RepeatModeAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.setRepeatMode(event.repeateMode);
    emit(state.copyWith(status: AudioPlayerStatus.repeate));
  }

  ///***********************Set Audio********************/
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

    await _addCurrentSongToRecentlyPlayed(emit);
    await _addCurrentSongToMostPlayed(emit);
    //  play song
    await _audioHandler.play();

    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  ///**************Load Recently Played Event*************/
  ///***************************************************/
  void _onLoadRecentlyPlayedEvent(
    LoadRecentlyPlayedEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    // Open the box for recently played songs
    final box = await recentlyPlayedRepoImpl.openBox();

    // Get the updated list of recently played songs
    final updatedList = recentlyPlayedRepoImpl.getSongs(box);
    emit(state.copyWith(
        status: AudioPlayerStatus.loaded, recentlyPlayed: updatedList));
  }

  ///**************Load Most Played Event*************/
  ///***************************************************/
  void _onMostPlayedEvent(
    MostPlayedEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    // Open the box for recently played songs
    final box = await mostPlayedRepoImpl.openBox();

    // Get the updated list of recently played songs
    final updatedList = mostPlayedRepoImpl.getSongs(box);
    emit(state.copyWith(
        status: AudioPlayerStatus.loaded, mostPlayed: updatedList));
  }

  ///** This method adds the currently playing song to the recently played list and updates the state.
  Future<void> _addCurrentSongToRecentlyPlayed(
      Emitter<AudioPlayerState> emit) async {
    if (state.audioPlayerData?.audio != null) {
      final currentSong = state.audioPlayerData!.audio!;
      final box = await recentlyPlayedRepoImpl.openBox();

      await recentlyPlayedRepoImpl.addSong(box, currentSong);

      final updatedList = recentlyPlayedRepoImpl.getSongs(box);

      emit(state.copyWith(
        recentlyPlayed: updatedList,
        status: AudioPlayerStatus.loaded,
      ));
    }
  }

  ///** This method adds the currently playing song to the Most played list and updates the state.
  Future<void> _addCurrentSongToMostPlayed(
      Emitter<AudioPlayerState> emit) async {
    if (state.audioPlayerData?.audio != null) {
      final currentSong = state.audioPlayerData!.audio!;
      final box = await mostPlayedRepoImpl.openBox();

      await mostPlayedRepoImpl.addSong(box, MostPlayedModel(song: currentSong));

      final updatedList = mostPlayedRepoImpl.getSongs(box);

      emit(state.copyWith(
        mostPlayed: updatedList,
        status: AudioPlayerStatus.loaded,
      ));
    }
  }
}
