#!/bin/bash
echo "Starting Flutter build..."
flutter pub get
flutter build apk
echo "Build complete."
