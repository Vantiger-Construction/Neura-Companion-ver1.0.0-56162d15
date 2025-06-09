@echo off
setlocal

REM ──────────────────────────────────────────────────────────────────────────
REM Build Script: One-click release APK builder for Neura Companion
REM ──────────────────────────────────────────────────────────────────────────

REM 1) Configure JDK and update PATH
set "JAVA_HOME=C:\Neura"
set "PATH=%JAVA_HOME%\bin;%PATH%"

REM 2) Write or update local.properties with Android SDK location
>local.properties echo sdk.dir=C\:\\Users\\KD\\AppData\\Local\\Android\\Sdk

REM 3) Ensure Gradle wrapper exists; generate if missing
if not exist gradlew.bat (
    echo [INFO] gradlew.bat not found — generating wrapper...
    gradle wrapper
    if errorlevel 1 (
        echo [WARN] Failed to generate Gradle wrapper. Ensure Gradle is installed locally.
    ) else (
        echo [OK] Gradle wrapper generated successfully.
    )
)

REM 4) Clean and assemble the release APK
echo.
echo [INFO] Cleaning and building release APK...
call gradlew.bat clean assembleRelease
if errorlevel 1 (
    echo.
    echo [ERROR] Build failed! Review errors above.
    pause
    exit /b 1
)

REM 5) Copy the built APK into the release directory
if not exist release mkdir release
copy /Y app\build\outputs\apk\release\app-release.apk release\app-release.apk >nul

REM 6) Success message with location

echo.
echo [OK] Build succeeded!
echo Release APK available at: %~dp0release\app-release.apk
pause
endlocal
