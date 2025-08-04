
import 'package:flutter/material.dart';

class NeuraVoiceReactiveWidget extends StatefulWidget {
  final String spokenText;
  final bool isSpeaking;
  final double emotionLevel; // 0.0 to 1.0

  NeuraVoiceReactiveWidget({
    required this.spokenText,
    this.isSpeaking = false,
    this.emotionLevel = 0.5,
  });

  @override
  _NeuraVoiceReactiveWidgetState createState() =>
      _NeuraVoiceReactiveWidgetState();
}

class _NeuraVoiceReactiveWidgetState extends State<NeuraVoiceReactiveWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 800), vsync: this);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut));

    if (widget.isSpeaking) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant NeuraVoiceReactiveWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSpeaking != oldWidget.isSpeaking) {
      widget.isSpeaking ? _controller.repeat(reverse: true) : _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnim,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _getEmotionColor(widget.emotionLevel),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.mic, size: 48, color: Colors.white),
      ),
    );
  }

  Color _getEmotionColor(double level) {
    if (level > 0.75) return Colors.pinkAccent;
    if (level > 0.5) return Colors.lightBlueAccent;
    if (level > 0.25) return Colors.orangeAccent;
    return Colors.grey;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
