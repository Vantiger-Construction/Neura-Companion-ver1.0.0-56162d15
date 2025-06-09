@echo off
REM === Neura Companion Android Studio Project Setup ===

echo [1] Cleaning workspace...
flutter clean

echo [2] Installing dependencies...
flutter pub get

echo [3] Running analyzer...
flutter analyze > android_studio_setup_log.txt

echo [4] Running all tests...
flutter test >> android_studio_setup_log.txt

echo [5] Launching Android Studio...
start "" "C:\Program Files\Android\Android Studio\bin\studio64.exe" .

echo.
echo === Neura Companion Android Studio Setup Complete ===
pause
