import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../home/data/most_played_repo.dart';
import '../../../home/data/recently_played_repo.dart';
import '../../../home/models/most_played_model.dart';
import '../../data/model/song.dart';
import '../../data/repository/audio_player_data.dart';
import 'package:rxdart/rxdart.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioHandler _audioHandler;
  final RecentlyPlayedRepoImpl recentlyPlayedRepoImpl;
  final MostPlayedRepoImpl mostPlayedRepoImpl;
  StreamSubscription<MediaItem?>? _streamMediaItem;
  AudioServiceRepeatMode _currentRepeatMode = AudioServiceRepeatMode.none;

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
    on<AddToRecentlyAndMostPlayedEvent>(
        _onAddToRecentlyAndMostPlayedEvent); // Listen Change Index
  }

  @override
  Future<void> close() {
    _streamMediaItem?.cancel();
    return super.close();
  }

  ///****************Load Audio Player*******************/
  ///***************************************************/
  /// Handles the loading of the audio player state and updates the state based on
  /// the combined streams of playback state, queue, current media item, and position.
  ///
  /// This method listens to changes in the audio player's data and updates the state
  /// accordingly. It also checks if a song is replayed in `repeat.one` mode and adds
  /// an event to update the recently and most played songs lists if necessary.
  void _onLoadAudioPlayer(
    LoadAudioPlayerEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    // Combine the streams of playback state, queue, current media item, and position
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
        // Map the current media item and queue to Song objects
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

    // Listen to the combined stream and update the state based on the data
    await emit.forEach(
      audioPlayerDataStream,
      onData: (data) {
        // Check if the current audio being played is the same as the previously stored audio
        final isSameAudio = state.audioPlayerData?.audio == data.audio;

        // Check if the last known position of the audio was greater than 2 seconds
        final isBeyondInitialPosition = state.lastKnownPosition != null &&
            state.lastKnownPosition! > const Duration(seconds: 2);

        // Check if the current position of the audio is less than 2 seconds,
        // indicating that the song has restarted
        final isRestarted = data.currentAudioPosition != null &&
            data.currentAudioPosition! < const Duration(seconds: 2);

        // Combine the checks to determine if the same song has restarted
        final isSongReplayed =
            isSameAudio && isBeyondInitialPosition && isRestarted;

        // If the song has restarted and the repeat mode is 'repeat.one',
        // add the song to recently and most played lists
        if (isSongReplayed &&
            _currentRepeatMode == AudioServiceRepeatMode.one) {
          add(AddToRecentlyAndMostPlayedEvent());
        }

        // Update the state with the new audio player data and current position
        return state.copyWith(
          audioPlayerData: data,
          lastKnownPosition: data.currentAudioPosition,
          status:
              (state.status == AudioPlayerStatus.initial && data.audio == null)
                  ? AudioPlayerStatus.initial
                  : AudioPlayerStatus.loaded,
        );
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
    emit(state.copyWith(status: AudioPlayerStatus.playing));
    add(AddToRecentlyAndMostPlayedEvent());
  }

  ///**************Skip To Previous Song*****************/
  ///***************************************************/
  void _onSkipToPreviousAudioEvent(
    SkipToPreviousAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.skipToPrevious();
    emit(state.copyWith(status: AudioPlayerStatus.playing));
    add(AddToRecentlyAndMostPlayedEvent());
  }

  ///*******************Skip by index********************/
  ///***************************************************/
  void _onSkipByIndexAudioEvent(
    SkipByIndexAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioHandler.skipToQueueItem(event.index);
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
    _currentRepeatMode = event.repeateMode;
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

    emit(state.copyWith(
      status: AudioPlayerStatus.playing,
      lastKnownPosition: Duration.zero,
    ));

    //  play song
    add(PlayAudioEvent());

    add(AddToRecentlyAndMostPlayedEvent());
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
  ///************************************************/
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

  ///*******Add To Recently And Most Played Event******/
  ///************************************************/
  void _onAddToRecentlyAndMostPlayedEvent(
    AddToRecentlyAndMostPlayedEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _addCurrentSongToMostPlayed(emit);
    await _addCurrentSongToRecentlyPlayed(emit);
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
