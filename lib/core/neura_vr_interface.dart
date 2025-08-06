
import 'package:flutter/material.dart';

class VRRoom {
  final String name;
  final Offset coordinates; // relative positioning
  final String moodTheme;

  VRRoom(this.name, this.coordinates, this.moodTheme);
}

class NeuraVRInterface {
  final List<VRRoom> rooms = [
    VRRoom('Reflection Bay', Offset(0, 0), 'calm'),
    VRRoom('Joy Lounge', Offset(1, 0), 'happy'),
    VRRoom('Mood Den', Offset(0, 1), 'neutral'),
    VRRoom('Focus Lab', Offset(-1, 0), 'productive'),
    VRRoom('Dreamscape', Offset(0, -1), 'mystical'),
  ];

  String? currentRoom;

  void syncRooms(String selectedRoomName) {
    final foundRoom = rooms.firstWhere(
      (r) => r.name == selectedRoomName,
      orElse: () => VRRoom('Unknown', Offset.zero, 'neutral'),
    );

    currentRoom = foundRoom.name;
    debugPrint('Neura teleported to: \$currentRoom (Mood: \${foundRoom.moodTheme})');

    // Trigger mood animation theme
    _triggerEnvironment(foundRoom.moodTheme);
  }

  void _triggerEnvironment(String moodTheme) {
    // Here you can tie into shader, animation, background logic
    debugPrint('Environment adjusted to mood: \$moodTheme');
  }

  List<String> getRoomNames() => rooms.map((r) => r.name).toList();
}
