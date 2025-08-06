
// 🔥 Neura Live AI Core – Decision Engine
class NeuraDecisionEngine {
  final UserProfile user;
  final MoodState mood;
  final UserContext context;

  NeuraDecisionEngine(this.user, this.mood, this.context);

  String decideNextAction() {
    if (user.prefersSilence && mood.isLow()) return 'soothingIdle';
    if (context.recentTriggers.contains("dream")) return 'dreamStart';
    if (mood.isHigh()) return 'celebrateMood';
    if (user.goals.isEmpty) return 'promptGoalSetup';
    return 'offerHelp';
  }
}

class UserProfile {
  String name;
  String preferredTone;
  List<String> moodPatterns;
  List<String> dreamThemes;
  bool likesRoutines;
  String lastGoal;

  UserProfile({
    required this.name,
    required this.preferredTone,
    required this.moodPatterns,
    required this.dreamThemes,
    required this.likesRoutines,
    required this.lastGoal,
  });
}

class MoodState {
  String emotion;
  bool isHigh() => ['happy', 'joyful', 'excited'].contains(emotion);
  bool isLow() => ['sad', 'anxious', 'tired'].contains(emotion);

  MoodState(this.emotion);
}

class UserContext {
  List<String> recentTriggers;
  UserContext(this.recentTriggers);
}
