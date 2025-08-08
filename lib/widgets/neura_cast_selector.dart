
import 'package:flutter/material.dart';

class AIPersona {
  final String name;
  final String description;
  final IconData icon;

  AIPersona({required this.name, required this.description, required this.icon});
}

class NeuraCastSelectorPage extends StatelessWidget {
  final List<AIPersona> personas = [
    AIPersona(name: "Neura", description: "Warm, caring, and adaptive.", icon: Icons.face),
    AIPersona(name: "Neuro", description: "Logical, motivating, strategic.", icon: Icons.psychology),
    AIPersona(name: "Child Mode", description: "Fun, curious, kid-friendly.", icon: Icons.child_care),
    AIPersona(name: "Legacy", description: "Preserves memories and wisdom.", icon: Icons.book),
  ];

  void selectPersona(BuildContext context, AIPersona persona) {
    // You can save this choice to preferences or state
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${persona.name} activated')),
    );
    // Trigger re-init of AI if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Your Neura Companion')),
      body: ListView.builder(
        itemCount: personas.length,
        itemBuilder: (_, i) {
          final p = personas[i];
          return Card(
            child: ListTile(
              leading: Icon(p.icon, size: 36),
              title: Text(p.name),
              subtitle: Text(p.description),
              onTap: () => selectPersona(context, p),
            ),
          );
        },
      ),
    );
  }
}
