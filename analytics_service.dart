import 'package:hive_flutter/hive_flutter.dart';

class AnalyticsService {
  static const _boxName = 'analytics_events';
  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  Future<void> logEvent(String name, [Map<String, dynamic>? props]) async {
    await _box.add({'name': name, 'props': props ?? {}, 'time': DateTime.now().toIso8601String()});
  }

  List<Map> queryEvents() => _box.values.cast<Map>().toList();
}
