@echo off
REM === Neura Companion Auto-Setup ===

echo Creating project directories...
mkdir lib
mkdir assets
mkdir test
mkdir build
mkdir android
mkdir ios
mkdir windows
mkdir web

echo Extracting core files...
tar -xf NeuraCompanion_HyperSync_ALL_FINAL_COMPLETE.zip

echo Fetching dependencies...
flutter pub get

echo Running tests...
flutter test > install_log.txt

echo Building APK...
flutter build apk --debug >> install_log.txt

echo Done!
pause
