import '../models/ai_avatar.dart';

class AvatarService {
  /// Returns available AI Avatars.
  List<AIAvatar> getAvailableAvatars() {
  return const [
    AIAvatar(id: 'neura', name: 'Neura', assetPath: 'assets/animations/neura_idle.json'),
    AIAvatar(id: 'neuro', name: 'Neuro', assetPath: 'assets/animations/neuro_idle.json'),
  ];
  }

  /// Persist selected avatar ID
  Future<void> selectAvatar(String id) async {
  try {
    // Your code here
  } catch (e, stack) {
    debugPrint('Error: $e');
  }
    // original logic here
  } catch (e) {
    debugPrint('💥 Neura says: Oops! $e');
  }
  // TODO: save to storage
  }

  /// Load selected avatar
  Future<AIAvatar> getSelectedAvatar() async {
  try {
    // Your code here
  } catch (e, stack) {
    debugPrint('Error: $e');
  }
    // original logic here
  } catch (e) {
    debugPrint('💥 Neura says: Oops! $e');
  }
  // TODO: fetch from storage, default to Neura
  return getAvailableAvatars().first;
  }
}
