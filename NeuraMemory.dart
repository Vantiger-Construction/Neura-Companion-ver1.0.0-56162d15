
import 'dart:convert';

class NeuraMemory {
  final List<Map<String, dynamic>> _memoryLog = [];

  void saveMemory({
    required String type,        // e.g., "journal", "mood", "dream", "voice"
    required String content,     // raw text or voice transcription
    required DateTime timestamp,
    Map<String, dynamic>? tags,  // optional metadata (emotion, location, etc)
  }) {
    final memory = {
      'type': type,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'tags': tags ?? {},
    };

    _memoryLog.add(memory);
    print('Memory saved: ' + jsonEncode(memory));
  }

  List<Map<String, dynamic>> getAll() => _memoryLog;

  List<Map<String, dynamic>> filterByType(String type) =>
      _memoryLog.where((m) => m['type'] == type).toList();

  void clear() => _memoryLog.clear();
}
