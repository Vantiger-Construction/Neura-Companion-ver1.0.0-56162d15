import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

// Placeholder implementations for testing
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

class LocalUsageRepository implements UsageRepository {
  @override
  Future<List<UsageEntry>> getAllEntries() async {
    // TODO: Implement local storage
    return [];
  }
}

class HiveAdapters {
  static void registerAdapters() {
    // TODO: Implement Hive adapters
  }
}

void main() {
  setUpAll(() async {
    final dir = Directory.systemTemp.createTempSync('hive_test');
    Hive.init(dir.path);
    Hive.registerAdapter(HiveUsageEntryAdapter());
    Hive.registerAdapter(HiveRitualAdapter());
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('saveEntry and getAllEntries roundtrip', () async {
    final repo = LocalUsageRepository();
    final now = DateTime.now();
    final entry = UsageEntry(
      id: 'test1',
      timestamp: now,
      type: 'meditation',
      source: 'manual',
      moodTag: 'calm',
    );
    await repo.saveEntry(entry);
    final result = await repo.getAllEntries();
    expect(result.length, greaterThanOrEqualTo(1));
    final fetched = result.firstWhere((e) => e.id == 'test1');
    expect(fetched.timestamp, equals(now));
    expect(fetched.type, 'meditation');
    expect(fetched.source, 'manual');
    expect(fetched.moodTag, 'calm');
  });
}
