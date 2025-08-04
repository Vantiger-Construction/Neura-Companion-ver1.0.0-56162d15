
class PersonalityTrait {
  final String name;
  double level; // 0.0 to 1.0

  PersonalityTrait(this.name, this.level);
}

class PersonaTraitEngine {
  final Map<String, PersonalityTrait> _traits = {
    'empathy': PersonalityTrait('empathy', 0.5),
    'humor': PersonalityTrait('humor', 0.5),
    'focus': PersonalityTrait('focus', 0.5),
    'curiosity': PersonalityTrait('curiosity', 0.5),
    'kindness': PersonalityTrait('kindness', 0.5),
  };

  Map<String, PersonalityTrait> get() {
    return _traits;
  }

  void updateTrait(String trait, double delta) {
    if (_traits.containsKey(trait)) {
      _traits[trait]!.level = (_traits[trait]!.level + delta).clamp(0.0, 1.0);
    }
  }

  void decayAll({double amount = 0.01}) {
    _traits.forEach((key, value) {
      value.level = (value.level - amount).clamp(0.0, 1.0);
    });
  }

  void evolveFromInteraction(String interactionType) {
    switch (interactionType) {
      case 'comfort':
        updateTrait('empathy', 0.1);
        updateTrait('kindness', 0.05);
        break;
      case 'joke':
        updateTrait('humor', 0.1);
        break;
      case 'goal_focus':
        updateTrait('focus', 0.1);
        break;
      case 'curious_question':
        updateTrait('curiosity', 0.1);
        break;
    }
  }
}
