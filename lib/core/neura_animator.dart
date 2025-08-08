import 'package:flutter/material.dart';
import 'dart:async';

class NeuraAnimator extends StatefulWidget {
  final String portraitAsset;
  const NeuraAnimator({required this.portraitAsset, Key? key}) : super(key: key);

  @override
  _NeuraAnimatorState createState() => _NeuraAnimatorState();
}

class _NeuraAnimatorState extends State<NeuraAnimator>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _waveController;
  late Timer _blinkTimer;
  bool _isBlinkClosed = false;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
      lowerBound: -0.03,
      upperBound: 0.03,
    )..repeat(reverse: true);
    _blinkTimer = Timer.periodic(
      Duration(seconds: 3 + (DateTime.now().millisecond % 4)),
      (_) => _triggerBlink(),
    );
  }

  void _triggerBlink() {
    setState(() => _isBlinkClosed = true);
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _isBlinkClosed = false);
    });
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _waveController.dispose();
    _blinkTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_breathingController, _waveController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _breathingController.value,
          child: Transform.rotate(
            angle: _waveController.value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(widget.portraitAsset),
                if (_isBlinkClosed)
                  Positioned(top: 60, child:
                    Container(width: 80, height: 20, color: Colors.black.withOpacity(0.8)))
              ],
            ),
          ),
        );
      }
    );
}
}
