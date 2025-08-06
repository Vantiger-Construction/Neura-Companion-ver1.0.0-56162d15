
import 'package:flutter/material.dart';

class OfflineSyncSettingsPage extends StatefulWidget {
  @override
  _OfflineSyncSettingsPageState createState() => _OfflineSyncSettingsPageState();
}

class _OfflineSyncSettingsPageState extends State<OfflineSyncSettingsPage> {
  bool isOfflineMode = false;
  bool isBackupEnabled = true;

  void toggleOfflineMode(bool enabled) {
    setState(() {
      isOfflineMode = enabled;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(enabled ? 'Offline Mode Enabled' : 'Offline Mode Disabled'),
    ));
  }

  void toggleBackup(bool enabled) {
    setState(() {
      isBackupEnabled = enabled;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(enabled ? 'Cloud Backup Enabled' : 'Cloud Backup Disabled'),
    ));
  }

  void manualBackup() {
    // Placeholder: replace with real Firebase or local export logic
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("📦 Data backed up to cloud (simulated)."),
    ));
  }

  void manualRestore() {
    // Placeholder: replace with real Firebase or local restore logic
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("🔄 Data restored from cloud (simulated)."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline Mode & Sync')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Offline Mode"),
              subtitle: Text("Disable all network features temporarily"),
              value: isOfflineMode,
              onChanged: toggleOfflineMode,
            ),
            SwitchListTile(
              title: Text("Cloud Backup"),
              subtitle: Text("Automatically back up data when online"),
              value: isBackupEnabled,
              onChanged: toggleBackup,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.backup),
              label: Text("Manual Backup"),
              onPressed: manualBackup,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.restore),
              label: Text("Manual Restore"),
              onPressed: manualRestore,
            ),
          ],
        ),
      ),
    );
  }
}
