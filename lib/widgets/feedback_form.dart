import 'package:flutter/material.dart';
import '../services/feedback_service.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _controller = TextEditingController();
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(controller: _controller, decoration: InputDecoration(labelText: 'Your feedback')),
          Slider(value: _rating.toDouble(), min: 1, max: 10, divisions: 9,
            label: '$_rating', onChanged: (v) => setState(() => _rating = v.toInt())),
          ElevatedButton(onPressed: () {
            FeedbackService().submit(_controller.text, _rating);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thanks for your feedback!')));
          }, child: Text('Submit')),
        ],
      ),
    );
}
}
