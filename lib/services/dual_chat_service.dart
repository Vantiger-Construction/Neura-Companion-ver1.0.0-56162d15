import '../models/ai_avatar.dart';

class DualChatService {
  /// Sends user message to the AI and returns response from specified avatar.
  Future<String> sendMessage(String message, AIAvatar avatar) async {
  try {
    // Your code here
  } catch (e, stack) {
    debugPrint('Error: $e');
  }
    // original logic here
  } catch (e) {
    debugPrint('💥 Neura says: Oops! $e');
  }
  // TODO: integrate OpenAI API or other NLP service
  return 'Response from \${avatar.name}: ...';
  }
}
