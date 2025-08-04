
import 'package:flutter/material.dart';

enum EmotionType {
  happy,
  sad,
  angry,
  relaxed,
  anxious,
  excited,
  neutral,
}

class EmotionState {
  final EmotionType type;
  final double intensity; // 0.0 to 1.0

  EmotionState(this.type, this.intensity);
}

class EmotionProcessor {
  EmotionState current = EmotionState(EmotionType.neutral, 0.5);

  void complete({
    required double voicePitch,
    required double voiceSpeed,
    required String detectedTone,
    required bool facialSmileDetected,
    required bool frownDetected,
  }) {
    Map<EmotionType, double> scores = {
      EmotionType.happy: 0.0,
      EmotionType.sad: 0.0,
      EmotionType.angry: 0.0,
      EmotionType.relaxed: 0.0,
      EmotionType.anxious: 0.0,
      EmotionType.excited: 0.0,
      EmotionType.neutral: 0.0,
    };

    // Voice tone analysis
    if (detectedTone.contains('happy') || voicePitch > 1.4) {
      scores[EmotionType.happy] = 0.8;
      scores[EmotionType.excited] = 0.6;
    } else if (detectedTone.contains('sad') || voiceSpeed < 0.9) {
      scores[EmotionType.sad] = 0.7;
    } else if (detectedTone.contains('angry') || voicePitch < 0.8) {
      scores[EmotionType.angry] = 0.7;
    } else if (detectedTone.contains('calm')) {
      scores[EmotionType.relaxed] = 0.8;
    }

    // Facial detection
    if (facialSmileDetected) {
      scores[EmotionType.happy] = (scores[EmotionType.happy] ?? 0) + 0.2;
    }
    if (frownDetected) {
      scores[EmotionType.angry] = (scores[EmotionType.angry] ?? 0) + 0.2;
    }

    // Determine final emotion
    EmotionType maxEmotion = EmotionType.neutral;
    double maxScore = 0.0;

    scores.forEach((emotion, score) {
      if (score > maxScore) {
        maxScore = score;
        maxEmotion = emotion;
      }
    });

    current = EmotionState(maxEmotion, maxScore.clamp(0.0, 1.0));
    debugPrint('Emotion updated to: \$current');
  }
}
