
import 'package:flutter/material.dart';
import 'dart:math';

class MoodMusicPlayerPage extends StatefulWidget {
  @override
  _MoodMusicPlayerPageState createState() => _MoodMusicPlayerPageState();
}

class _MoodMusicPlayerPageState extends State<MoodMusicPlayerPage> {
  final List<String> moods = ['happy', 'sad', 'relaxed', 'focused', 'anxious', 'excited'];
  final Map<String, String> moodTracks = {
    'happy': 'assets/music/happy_tune.mp3',
    'sad': 'assets/music/sad_theme.mp3',
    'relaxed': 'assets/music/relax_wave.mp3',
    'focused': 'assets/music/focus_loop.mp3',
    'anxious': 'assets/music/calm_breath.mp3',
    'excited': 'assets/music/hype_beat.mp3',
  };

  String selectedMood = 'relaxed';

  void playMoodTrack(String mood) {
    setState(() {
      selectedMood = mood;
    });

    // Placeholder for real audio playback integration
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("🎵 Playing ${mood.toUpperCase()} mood track..."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Neura Mood Music")),
      body: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (_, i) {
          final mood = moods[i];
          return ListTile(
            leading: Icon(Icons.music_note),
            title: Text("Mood: ${mood[0].toUpperCase() + mood.substring(1)}"),
            subtitle: Text("Track: ${moodTracks[mood]?.split('/').last ?? 'N/A'}"),
            trailing: IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () => playMoodTrack(mood),
            ),
          );
        },
      ),
    );
  }
}
