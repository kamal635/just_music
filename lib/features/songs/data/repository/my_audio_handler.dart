import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initMyAudioHandler() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.mycompany.myapp.channel.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationOngoing: false,
      androidStopForegroundOnPause: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer();
  final _queue = ConcatenatingAudioSource(children: []);
  final _updateController = StreamController<PlaybackEvent>.broadcast();

  MyAudioHandler() {
    _loadEmptyPlaylist();
    _listenForDurationChanges();

    _updateController.stream.map(_transformEvent).pipe(playbackState);

    _player.playbackEventStream.listen((event) {
      _updateController.add(event);
    });

    _player.shuffleModeEnabledStream.listen((_) {
      _updateController.add(_player.playbackEvent);
    });

    _player.loopModeStream.listen((_) {
      _updateController.add(_player.playbackEvent);
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> skipToNext() async {
    if (_player.loopMode == LoopMode.one) {
      _player.setLoopMode(LoopMode.off);
      await _player.seekToNext();
      _player.setLoopMode(LoopMode.one);
    } else {
      await _player.seekToNext();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_player.loopMode == LoopMode.one) {
      _player.setLoopMode(LoopMode.off);
      await _player.seekToPrevious();
      _player.setLoopMode(LoopMode.one);
    } else {
      await _player.seekToPrevious();
    }
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    if (enabled) {
      _player.shuffle();
    }
    _player.setShuffleModeEnabled(enabled);

    _updateController.add(_player.playbackEvent);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
      case AudioServiceRepeatMode.group:
        return;
    }
    _updateController.add(_player.playbackEvent);
  }

  @override
  Future<void> skipToQueueItem(int index) =>
      _player.seek(Duration.zero, index: index);

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    try {
      await _queue.clear();

      final audioSources = mediaItems
          .where((mediaItem) {
            final filePath = mediaItem.extras!['audioUrl'] as String;
            final fileExists = File(filePath).existsSync();
            if (!fileExists) {
              debugPrint("File not found: $filePath");
            }
            return fileExists;
          })
          .map((mediaItem) => AudioSource.uri(
                Uri.parse(mediaItem.extras!['audioUrl'] as String),
                tag: mediaItem,
              ))
          .toList();

      if (audioSources.isEmpty) {
        debugPrint("No valid audio files to play.");
        return;
      }

      _queue.addAll(audioSources);

      final newQueue = queue.value..addAll(mediaItems);
      queue.add(newQueue);
    } catch (e) {
      debugPrint("Error in add queue items: ${e.toString()}");
      skipToNext();
    }
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_queue);
    } catch (err) {
      debugPrint('Error loading empty playlist: $err');
    }
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      var index = _player.currentIndex;
      final newQueue = queue.value;

      if (index == null || newQueue.isEmpty) return;

      if (index < newQueue.length) {
        final oldMediaItem = newQueue[index];
        final newMediaItem = oldMediaItem.copyWith(duration: duration);
        newQueue[index] = newMediaItem;
        queue.add(newQueue);
        mediaItem.add(newMediaItem);
      }
    });
  }

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
