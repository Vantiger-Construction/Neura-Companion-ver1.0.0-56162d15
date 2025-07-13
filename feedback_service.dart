import 'package:hive_flutter/hive_flutter.dart';

class FeedbackService {
  static const _boxName = 'feedback';
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }
  Future<void> submit(String comment, int rating) async {
    final box = Hive.box(_boxName);
    await box.add({'comment': comment, 'rating': rating, 'time': DateTime.now().toIso8601String()});
  }
}
