import 'package:flutter/material.dart';

void main() {
  runApp(const JustMusicApp());
}

class JustMusicApp extends StatelessWidget {
  const JustMusicApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestGit(),
    );
  }
}

class TestGit extends StatelessWidget {
  const TestGit({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
