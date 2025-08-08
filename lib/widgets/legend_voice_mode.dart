
import 'package:flutter/material.dart';

class LegendVoiceSettingsPage extends StatefulWidget {
  @override
  _LegendVoiceSettingsPageState createState() => _LegendVoiceSettingsPageState();
}

class _LegendVoiceSettingsPageState extends State<LegendVoiceSettingsPage> {
  bool isLegendVoiceEnabled = false;
  String activationPhrase = "Activate Maker Mode";

  void toggleLegendVoice(bool enabled) {
    setState(() {
      isLegendVoiceEnabled = enabled;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(enabled
          ? 'LEGEND voice activated. Neura now recognizes you as The Maker.'
          : 'LEGEND voice deactivated.'),
    ));
  }

  void updatePhrase(String phrase) {
    setState(() {
      activationPhrase = phrase;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LEGEND Voice Mode')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Enable LEGEND Voice"),
              subtitle: Text("Allow Neura to recognize your special voice mode"),
              value: isLegendVoiceEnabled,
              onChanged: toggleLegendVoice,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Activation Phrase",
                hintText: "e.g., 'Activate Maker Mode'",
              ),
              onChanged: updatePhrase,
            ),
            SizedBox(height: 20),
            Text("Current Phrase: "$activationPhrase"", style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
