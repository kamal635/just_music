import 'package:flutter/material.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({super.key});

  @override
  _AnimatedPageState createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> {
  bool _isFieldVisible = false;
  bool _isListVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isFieldVisible = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _isListVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated TextField and SliverList'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              transform: _isFieldVisible
                  ? Matrix4.translationValues(0, 0, 0)
                  : Matrix4.translationValues(0, -50, 0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter text',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return AnimatedOpacity(
                  opacity: _isListVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeIn,
                  child: ListTile(
                    title: Text('Item #$index'),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
