import 'package:flutter/material.dart';
import 'modules/navigation/enhanced_navigation.dart';
import 'modules/core/ai_engine.dart';

class NeuroCompanionApp extends StatelessWidget {
  const NeuroCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Neuro Companion',
    theme: ThemeData.dark(),
    home: const EnhancedNavigation(),
  );
  }
}
