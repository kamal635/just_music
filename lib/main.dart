import 'package:flutter/material.dart';
import 'package:just_music/core/functions/init_method.dart';
import 'package:just_music/features/home/data/repository/my_audio_handler.dart';
import 'package:just_music/just_music_app.dart';

Future<void> main() async {
  // All necessary methods are in main.dart
  await initMethod();

  final audioHandler = await initMyAudioHandler();

  runApp(JustMusicApp(audioHandler: audioHandler));
}
