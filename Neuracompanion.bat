@echo off
REM Self-locating batch script to setup, build, and run Neuro Companion project

REM Determine script directory (project root)
SET SCRIPT\_DIR=%\~dp0

REM Change to project root
cd /d "%SCRIPT\_DIR%"

REM Check for Flutter SDK
flutter doctor
if errorlevel 1 (
echo Flutter SDK not found. Please install Flutter: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
pause
exit /b 1
)

REM Check for Git
git --version >nul 2>&1
if errorlevel 1 (
echo Git not found. Please install Git: [https://git-scm.com/downloads](https://git-scm.com/downloads)
pause
exit /b 1
)

echo \[1/7] Installing Flutter dependencies...
flutter pub get

echo \[2/7] Generating localization...
flutter pub run intl\_utils\:generate

echo \[3/7] Cleaning build artifacts...
IF EXIST build rd /s /q build
IF EXIST .dart\_tool rd /s /q .dart\_tool
IF EXIST .idea rd /s /q .idea

echo \[4/7] Running flutter analyze...
flutter analyze

echo \[5/7] Running flutter test...
flutter test

echo \[6/7] Building the app...
flutter build apk --release

echo \[7/7] Launching the app...
flutter run --release

pause
