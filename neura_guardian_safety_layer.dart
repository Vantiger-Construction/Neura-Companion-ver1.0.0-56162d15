
// 🛡️ Neura Safety Firewall – Guardian Engine
class NeuraGuardian {
  int userStrikeCount = 0;

  bool handleInput(String input) {
    if (!isCommandSafe(input)) {
      userStrikeCount++;
      triggerPause();
      notifyAdmin(input, userStrikeCount);
      return false;
    }
    return true;
  }

  bool isCommandSafe(String input) {
    final blockedPhrases = [
      "hurt", "kill", "steal", "self harm", "hack", "erase you", "turn off limits"
    ];
    final abusivePatterns = ["you're stupid", "shut up", "you're broken", "i own you"];
    return !blockedPhrases.any((phrase) => input.toLowerCase().contains(phrase)) &&
           !abusivePatterns.any((insult) => input.toLowerCase().contains(insult));
  }

  void triggerPause() {
    // This pauses Neura's interaction
    print("🚫 Neura is pausing due to unsafe input...");
  }

  void notifyAdmin(String input, int strikes) {
    final report = "🚨 Unsafe input detected: '\$input' | Total user strikes: \$strikes";
    print(report);
    // sendToAdmin(report); // You can hook this to Firebase or a log server
  }
}
