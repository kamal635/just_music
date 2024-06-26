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

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();
  final _queue = ConcatenatingAudioSource(children: []);

// constractor
  MyAudioHandler() {
    _loadEmptyPlaylist();
    _listenForDurationChanges();

    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToQueueItem(int index) =>
      _player.seek(Duration.zero, index: index);

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final audioSources = mediaItems
        .map((mediaItem) => AudioSource.uri(
              Uri.parse(mediaItem.extras!['audioUrl'] as String),
              tag: mediaItem,
            ))
        .toList();

    _queue.addAll(audioSources);

    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_queue);
    } catch (err) {
      print('Error loading empty playlist: $err');
    }
  }

  /// [durationStream] this give us an update every time the duration
  /// of the song that the audio player is currently playing changes
  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      var index =
          _player.currentIndex; // Index of the current song being played
      final newQueue = queue.value; // current playback queue

      if (index == null || newQueue.isEmpty) return; // there is no song

      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: _player.currentIndex,
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
}
