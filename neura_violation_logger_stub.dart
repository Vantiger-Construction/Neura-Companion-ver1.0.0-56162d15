
// 🔐 Neura Firebase Violation Logger
import 'package:cloud_firestore/cloud_firestore.dart';

class NeuraViolationLogger {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logViolation(String userId, String input, int strikes) async {
    await _db.collection("neuraViolations").add({
      "userId": userId,
      "input": input,
      "strikeCount": strikes,
      "timestamp": FieldValue.serverTimestamp(),
    });
    print("🛡️ Violation logged to Firebase.");
  }
}
