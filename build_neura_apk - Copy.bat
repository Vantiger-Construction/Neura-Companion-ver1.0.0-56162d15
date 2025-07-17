@echo off
echo Building Neura Companion APK...
flutter clean
flutter pub get
flutter build apk --release
echo APK build complete!
echo Output: build\app\outputs\flutter-apk\app-release.apk
pause
