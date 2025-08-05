import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

// Simple placeholder models and services since they're not implemented yet
class UsageEntry {
  final String id;
  final DateTime timestamp;
  final String type;
  final Map<String, dynamic> data;

  UsageEntry({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.data,
  });
}

abstract class UsageRepository {
  Future<List<UsageEntry>> getAllEntries();
}

class CsvExportService {
  static Future<File> exportToCSV(List<UsageEntry> entries) async {
    // TODO: Implement CSV export
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/export.csv');
    await file.writeAsString('id,timestamp,type,data\n');
    return file;
  }
}

class FakeRepo implements UsageRepository {
  @override
  Future<List<UsageEntry>> getAllEntries() async {
    return [
      UsageEntry(
        id: '1',
        timestamp: DateTime.utc(2025, 1, 1, 12, 0),
        type: 'test',
        source: 'unit-test',
        moodTag: 'happy',
      ),
      UsageEntry(
        id: '2',
        timestamp: DateTime.utc(2025, 1, 2, 13, 30),
        type: 'test2',
        source: 'unit-test',
        moodTag: 'sad',
      ),
    ];
  }
  @override
  Future<void> saveEntry(UsageEntry entry) => throw UnimplementedError();
}

void main() {
  test('exportAllEntries creates a CSV file', () async {
    final repo = FakeRepo();
    final service = CsvExportService(repo);
    final path = await service.exportAllEntries();
    final file = File(path);
    expect(await file.exists(), isTrue);
    final lines = await file.readAsLines();
    expect(lines.length, 3);
    expect(lines[0], 'ID,Timestamp,Type,Source,MoodTag');
    await file.delete();
  });
}
