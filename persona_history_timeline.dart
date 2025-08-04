
import 'package:flutter/material.dart';

class EmotionSnapshot {
  final DateTime timestamp;
  final String emotion;
  final double intensity;

  EmotionSnapshot(this.timestamp, this.emotion, this.intensity);
}

class PersonaHistoryTimelinePage extends StatelessWidget {
  final List<EmotionSnapshot> emotionHistory;

  PersonaHistoryTimelinePage({required this.emotionHistory});

  @override
  Widget build(BuildContext context) {
    emotionHistory.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return Scaffold(
      appBar: AppBar(title: Text('Persona Memory Timeline')),
      body: ListView.builder(
        itemCount: emotionHistory.length,
        itemBuilder: (context, index) {
          final snap = emotionHistory[index];
          return ListTile(
            leading: Icon(Icons.timeline),
            title: Text(snap.emotion),
            subtitle: Text(
              '${snap.timestamp.toLocal()} - Intensity: ${snap.intensity.toStringAsFixed(2)}',
            ),
            tileColor: _getColor(snap.emotion).withOpacity(snap.intensity),
          );
        },
      ),
    );
  }

  Color _getColor(String emotion) {
    switch (emotion) {
      case 'happy':
        return Colors.yellowAccent;
      case 'sad':
        return Colors.blueGrey;
      case 'angry':
        return Colors.redAccent;
      case 'relaxed':
        return Colors.lightBlueAccent;
      case 'anxious':
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }
}
