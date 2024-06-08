import 'package:flutter/material.dart';
import 'package:just_music/core/functions/init_method.dart';
import 'package:just_music/just_music_app.dart';

Future<void> main() async {
  await initMethod();

  runApp(const JustMusicApp());
}
