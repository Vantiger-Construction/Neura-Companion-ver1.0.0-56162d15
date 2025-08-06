
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> tutorialPages = [
    {
      "title": "Welcome to Neura",
      "body": "Your AI companion who grows with you, emotionally and mentally.",
    },
    {
      "title": "Track Your Mood",
      "body": "Neura monitors your voice, behavior, and expressions to guide your well-being.",
    },
    {
      "title": "Unlock New Abilities",
      "body": "From dream analysis to smart rituals, Neura evolves to help you thrive.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemCount: tutorialPages.length,
        itemBuilder: (_, i) {
          final page = tutorialPages[i];
          return Container(
            padding: EdgeInsets.all(24),
            color: Colors.deepPurple.shade50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(page["title"]!, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text(page["body"]!, style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
      bottomSheet: _currentIndex == tutorialPages.length - 1
          ? TextButton(
              child: Text("Let’s Begin", style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.pop(context); // or go to dashboard
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                tutorialPages.length,
                (index) => Container(
                  margin: EdgeInsets.all(4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.purple : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
    );
  }
}
