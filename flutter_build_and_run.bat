@echo off
REM Flutter development batch script with improved error handling and comments

echo [1/9] Checking Flutter SDK...
flutter doctor
if errorlevel 1 (
    echo Flutter SDK not found. Please install Flutter: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

echo [2/9] Checking Git...
git --version >nul 2>&1
if errorlevel 1 (
    echo Git not found. Please install Git: https://git-scm.com/downloads
    pause
    exit /b 1
)

echo [3/9] Installing Flutter dependencies...
flutter pub get
if errorlevel 1 (
    echo Failed to install Flutter dependencies.
    pause
    exit /b 1
)

echo [4/9] Generating localization...
flutter pub run intl_utils:generate
if errorlevel 1 (
    echo Failed to generate localization.
    pause
    exit /b 1
)

echo [5/9] Cleaning build artifacts...
REM Remove build, .dart_tool, and .idea directories if they exist
IF EXIST build rd /s /q build
IF EXIST .dart_tool rd /s /q .dart_tool
IF EXIST .idea rd /s /q .idea

echo [6/9] Running flutter analyze...
flutter analyze
if errorlevel 1 (
    echo Flutter analyze found issues.
    pause
    exit /b 1
)

echo [7/9] Running flutter test...
flutter test
if errorlevel 1 (
    echo Flutter tests failed.
    pause
    exit /b 1
)

echo [8/9] Building the app (APK release)...
flutter build apk --release
if errorlevel 1 (
    echo Flutter build failed.
    pause
    exit /b 1
)

echo [9/9] Launching the app (release mode)...
flutter run --release
if errorlevel 1 (
    echo Failed to launch the app.
    pause
    exit /b 1
)

pause
