import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../services/analytics_service.dart';
import '../services/error_logger.dart';

class DiagnosticsScreen extends StatefulWidget {
  @override
  _DiagnosticsScreenState createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
  final _analytics = AnalyticsService();
  List<Map> _events = [];
  String _logs = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _analytics.init();
    final events = _analytics.queryEvents();
    final dir = await getTemporaryDirectory();
    final file = File('\${dir.path}/neura_errors.log');
    final logs = await (file.exists() ? file.readAsString() : Future.value('No logs'));
    setState(() {
      _events = events;
      _logs = logs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: Text('Events'), subtitle: Text(_events.map((e) => e['name']).join(', '))),
        ExpansionTile(title: Text('Error Logs'), children: [Padding(padding: EdgeInsets.all(8), child: Text(_logs))]),
      ],
    );
  }
}
