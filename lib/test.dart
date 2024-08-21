import 'package:flutter/material.dart';

class TestSongs extends StatefulWidget {
  const TestSongs({super.key});

  @override
  State<TestSongs> createState() => _TestSongsState();
}

class _TestSongsState extends State<TestSongs> {
  late ScrollController _scrollController;
  int itemCount = 80;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final currentPosition = _scrollController.position.pixels;
    final maxPosition = _scrollController.position.maxScrollExtent;
    if (currentPosition >= maxPosition / 2) {
      itemCount += 80;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      controller: _scrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Text("$itemCount");
      },
    ));
  }
}
