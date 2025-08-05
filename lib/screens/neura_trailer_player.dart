
import 'package:flutter/material.dart';

class NeuraTrailerPlayer extends StatelessWidget {
  final String videoUrl;

  NeuraTrailerPlayer({this.videoUrl = 'https://example.com/neura-trailer.mp4'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watch Neura Trailer')),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black12,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_fill, size: 64, color: Colors.purpleAccent),
                  SizedBox(height: 12),
                  Text("Tap to watch Neura Trailer"),
                  SizedBox(height: 8),
                  Text(
                    videoUrl,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
