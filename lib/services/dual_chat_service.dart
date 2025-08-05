import 'package:your_app/utils/neura_funny_error.dart';
import '../models/ai_avatar.dart';

class DualChatService {
  /// Sends user message to the AI and returns response from specified avatar.
  // 🛡️ Error-handled
try {
  Future<String> sendMessage(String message, AIAvatar avatar) async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  // TODO: integrate OpenAI API or other NLP service
  return 'Response from \${avatar.name}: ...';
  }
}
