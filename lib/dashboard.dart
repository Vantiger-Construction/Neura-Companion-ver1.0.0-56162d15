
import 'package:flutter/material.dart';
import 'modules/neura_therapist_module.dart';
import 'modules/neura_goal_navigator.dart';
import 'modules/neura_meditation_coach.dart';
import 'modules/neura_dream_visualizer.dart';
import 'modules/neura_moodnet_feed.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Neura Companion")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ListTile(
            leading: Icon(Icons.psychology),
            title: Text("Neura Therapist Mode"),
            subtitle: Text("Reflect, talk, and get feedback"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NeuraTherapistModule()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text("Goal Navigator"),
            subtitle: Text("Break goals into small steps"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NeuraGoalNavigator()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.spa),
            title: Text("Meditation Coach"),
            subtitle: Text("Relax and breathe with Neura"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NeuraMeditationCoach()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.nightlight_round),
            title: Text("Dream Visualizer"),
            subtitle: Text("Log and review dream entries"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NeuraDreamVisualizer()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.wifi),
            title: Text("MoodNet Feed"),
            subtitle: Text("See what others are feeling"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NeuraMoodNetFeed()),
              );
            },
          ),
        ],
      ),
    );
  }
}
