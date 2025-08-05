
import 'package:flutter/material.dart';

class ModuleSettingsPage extends StatefulWidget {
  @override
  _ModuleSettingsPageState createState() => _ModuleSettingsPageState();
}

class _ModuleSettingsPageState extends State<ModuleSettingsPage> {
  Map<String, bool> moduleToggles = {
    'Dream Visualizer': true,
    'Emotion Tracker': true,
    'Neura Voice': true,
    'Ritual Feed': true,
    'Mood Music': true,
    'Clinical Mode': false,
    'Global Mood Map': true,
    'NeuraCast Switcher': true,
    'Memory Graph': true,
  };

  void toggleModule(String moduleName, bool enabled) {
    setState(() {
      moduleToggles[moduleName] = enabled;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${moduleName} has been ${enabled ? "enabled" : "disabled"}'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Module Configuration")),
      body: ListView(
        children: moduleToggles.entries.map((entry) {
          return SwitchListTile(
            title: Text(entry.key),
            subtitle: Text("Toggle this module on/off"),
            value: entry.value,
            onChanged: (val) => toggleModule(entry.key, val),
          );
        }).toList(),
      ),
    );
  }
}
