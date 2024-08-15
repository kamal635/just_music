import 'package:flutter/material.dart';
import 'core/functions/init_method.dart';
import 'features/songs/data/repository/my_audio_handler.dart';
import 'just_music_app.dart';

Future<void> main() async {
  // All necessary methods are in main.dart
  await initMethod();

  final audioHandler = await initMyAudioHandler();

  runApp(JustMusicApp(audioHandler: audioHandler));
}
