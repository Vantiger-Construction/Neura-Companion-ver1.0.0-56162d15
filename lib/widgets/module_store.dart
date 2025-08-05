
import 'package:flutter/material.dart';

class UnlockableItem {
  final String name;
  final String description;
  final bool unlocked;
  final IconData icon;

  UnlockableItem({
    required this.name,
    required this.description,
    this.unlocked = false,
    required this.icon,
  });
}

class ModuleStorePage extends StatefulWidget {
  @override
  _ModuleStorePageState createState() => _ModuleStorePageState();
}

class _ModuleStorePageState extends State<ModuleStorePage> {
  List<UnlockableItem> items = [
    UnlockableItem(
      name: "Dream Visualizer+",
      description: "Unlock animated dream playback scenes",
      unlocked: false,
      icon: Icons.auto_awesome,
    ),
    UnlockableItem(
      name: "Outfit Pack Alpha",
      description: "New looks for Neura's daily moods",
      unlocked: true,
      icon: Icons.checkroom,
    ),
    UnlockableItem(
      name: "VR Ritual Room",
      description: "Unlock immersive ritual room in VR",
      unlocked: false,
      icon: Icons.vrpano,
    ),
    UnlockableItem(
      name: "Memory Graph",
      description: "Unlock advanced mood and memory insights",
      unlocked: true,
      icon: Icons.timeline,
    ),
  ];

  void toggleUnlock(int index) {
    setState(() {
      items[index] = UnlockableItem(
        name: items[index].name,
        description: items[index].description,
        unlocked: !items[index].unlocked,
        icon: items[index].icon,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Neura Module Store")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];
          return Card(
            child: ListTile(
              leading: Icon(item.icon, size: 36),
              title: Text(item.name),
              subtitle: Text(item.description),
              trailing: IconButton(
                icon: Icon(
                  item.unlocked ? Icons.lock_open : Icons.lock,
                  color: item.unlocked ? Colors.green : Colors.grey,
                ),
                onPressed: () => toggleUnlock(i),
              ),
            ),
          );
        },
      ),
    );
  }
}
