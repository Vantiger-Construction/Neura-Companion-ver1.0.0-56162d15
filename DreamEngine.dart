
import 'package:flutter/material.dart';

class DreamScene {
  final String title;
  final List<String> keywords;
  final Duration duration;

  DreamScene({required this.title, required this.keywords, this.duration = const Duration(seconds: 10)});
}

class DreamEngine {
  final List<DreamScene> dreamQueue = [];

  void enqueueDream(DreamScene scene) {
    dreamQueue.add(scene);
    debugPrint('Enqueued dream: \${scene.title}');
  }

  Widget animateDream() {
    if (dreamQueue.isEmpty) {
      return Center(child: Text('No dreams to animate'));
    }

    final current = dreamQueue.removeAt(0);

    return Scaffold(
      appBar: AppBar(title: Text('Dream: \${current.title}')),
      body: DreamVisualizer(keywords: current.keywords),
    );
  }
}

class DreamVisualizer extends StatefulWidget {
  final List<String> keywords;

  DreamVisualizer({required this.keywords});

  @override
  _DreamVisualizerState createState() => _DreamVisualizerState();
}

class _DreamVisualizerState extends State<DreamVisualizer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 8));
    _fade = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: widget.keywords.map((kw) => Text(
          kw,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        )).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
