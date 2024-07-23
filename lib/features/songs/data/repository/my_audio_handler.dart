import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initMyAudioHandler() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.mycompany.myapp.channel.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer();
  final _queue = ConcatenatingAudioSource(children: []);
  final _updateController = StreamController<PlaybackEvent>.broadcast();

  ///*********** Constractor My AudioHandler ************/
  ///***************************************************/
  MyAudioHandler() {
    _loadEmptyPlaylist();
    _listenForDurationChanges();

    // Redirect events from the update controller to the playback state
    _updateController.stream.map(_transformEvent).pipe(playbackState);

    // Listen to player events and add them to the update controller
    _player.playbackEventStream.listen((event) {
      _updateController.add(event);
    });

    // Listen to shuffle mode changes
    _player.shuffleModeEnabledStream.listen((_) {
      _updateController.add(_player.playbackEvent);
    });

    _player.loopModeStream.listen((_) {
      _updateController.add(_player.playbackEvent);
    });
  }

  ///********************** Play ************************/
  ///***************************************************/
  @override
  Future<void> play() => _player.play();

  ///********************** Pause ***********************/
  ///***************************************************/
  @override
  Future<void> pause() => _player.pause();

  ///******************** Stop **************************/
  ///***************************************************/
  @override
  Future<void> stop() => _player.stop();

  ///****************** Skip To Next ********************/
  ///***************************************************/

  @override
  Future<void> skipToNext() => _player.seekToNext();

  ///***************** Skip To Previous *****************/
  ///***************************************************/
  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  ///***************** Seek Duration ********************/
  ///***************************************************/
  @override
  Future<void> seek(Duration position) => _player.seek(position);

  ///**************** Set Shuffle Mode ******************/
  ///***************************************************/
  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    if (enabled) {
      _player.shuffle();
    }
    _player.setShuffleModeEnabled(enabled);

    _updateController.add(_player.playbackEvent);
  }

  ///**************** Set Repeat Mode ******************/
  ///***************************************************/
  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
      case AudioServiceRepeatMode.group:
        return;
    }
    _updateController.add(_player.playbackEvent);
  }

  ///***************** Skip To Queue Item ***************/
  ///***************************************************/
  @override
  Future<void> skipToQueueItem(int index) =>
      _player.seek(Duration.zero, index: index);

  ///***************** Add Queue Items ******************/
  ///***************************************************/
  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // Clear the existing _queue
    await _queue.clear();

    // Map mediaItems to audioSources
    final audioSources = mediaItems
        .map((mediaItem) => AudioSource.uri(
              Uri.parse(mediaItem.extras!['audioUrl'] as String),
              tag: mediaItem,
            ))
        .toList();

    // Add new audioSources to the queue
    _queue.addAll(audioSources);

    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  ///************** Load Empty Playlist *****************/
  ///***************************************************/
  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_queue);
    } catch (err) {
      print('Error loading empty playlist: $err');
    }
  }

  //** [durationStream] this give us an update every time the duration
  //** of the song that the audio player is currently playing changes
  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      var index =
          _player.currentIndex; // Index of the current song being played
      final newQueue = queue.value; // current playback queue

      if (index == null || newQueue.isEmpty) return; // there is no song

      if (index <= newQueue.length) {
        final oldMediaItem = newQueue[index];
        final newMediaItem = oldMediaItem.copyWith(duration: duration);
        newQueue[index] = newMediaItem;
        queue.add(newQueue);
        mediaItem.add(newMediaItem);
      }
    });
  }

  // ///****** */ Listen to Processing State Stream *****/
  // ///*** If was is completed and song is playing ****/
  // ///*** return play music from index 0 ****/
  // Future<void> _returnPlayPlaylistWhenIsCompleted() async {
  //   _player.processingStateStream.listen((state) {
  //     final isCompleted = state == ProcessingState.completed;
  //     final isPlaying = _player.playing == true;

  //     if (isCompleted && isPlaying) {
  //       _player.play();
  //       _player.seek(Duration.zero, index: 0);
  //     }
  //   });
  // }

  ///**************** Transform Event *******************/
  ///***************************************************/
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: _player.currentIndex,
      shuffleMode: {
        true: AudioServiceShuffleMode.all,
        false: AudioServiceShuffleMode.none,
      }[_player.shuffleModeEnabled]!,
      repeatMode: {
        LoopMode.all: AudioServiceRepeatMode.all,
        LoopMode.one: AudioServiceRepeatMode.one,
        LoopMode.off: AudioServiceRepeatMode.none,
      }[_player.loopMode]!,
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
    );
  }

  void closeListeners() {
    _updateController.close();
  }
}
