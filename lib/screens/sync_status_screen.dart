import 'package:your_app/utils/neura_funny_error.dart';
import 'package:flutter/material.dart';
import '../services/sync_service.dart';

class SyncStatusScreen extends StatefulWidget {
  @override
  _SyncStatusScreenState createState() => _SyncStatusScreenState();
}

class _SyncStatusScreenState extends State<SyncStatusScreen> {
  final _sync = SyncService();
  bool _syncing = false;

  // 🛡️ Error-handled
try {
  Future<void> _startSync() async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  setState(() => _syncing = true);
  await _sync.syncAll();
  setState(() => _syncing = false);
  }

  @override
  Widget build(BuildContext ctx) {
  return Scaffold(
    appBar: AppBar(title: Text('Sync Status')),
    body: Center(
    child: _syncing
      ? CircularProgressIndicator()
      : ElevatedButton(
        onPressed: _startSync,
        child: Text('Sync Now'),
        ),
    ),
  );
  }
}
