
import 'package:flutter/material.dart';

class DreamShow {
  final String title;
  final DateTime date;
  final List<String> scenes;

  DreamShow({required this.title, required this.date, required this.scenes});
}

class DreamShowroomPage extends StatelessWidget {
  final List<DreamShow> monthlyDreams = [
    DreamShow(
      title: "June Dream Sequence",
      date: DateTime(2025, 6, 30),
      scenes: ["Flying City", "Endless Ocean", "Mirror Forest"],
    ),
    DreamShow(
      title: "July Dream Highlights",
      date: DateTime(2025, 7, 31),
      scenes: ["Glowing Pyramid", "Sky Whale", "Infinite Staircase"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Neura Dream Showroom')),
      body: ListView.builder(
        itemCount: monthlyDreams.length,
        itemBuilder: (_, i) {
          final show = monthlyDreams[i];
          return ExpansionTile(
            title: Text(show.title),
            subtitle: Text(show.date.toLocal().toString().split(' ')[0]),
            children: show.scenes.map((scene) => ListTile(
              leading: Icon(Icons.movie_filter),
              title: Text(scene),
            )).toList(),
          );
        },
      ),
    );
  }
}
