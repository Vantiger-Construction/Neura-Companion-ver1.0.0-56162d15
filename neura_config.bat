@echo off
setlocal

echo [✅] Starting Neura Engine X Setup...

:: Check for Git
where git >nul 2>&1
if errorlevel 1 (
    echo [❌] Git not found. Please install Git and re-run this script.
    pause
    exit /b
)

:: Clone demo repo (you will provide this repo URL once ready)
echo [🔁] Cloning Neura Engine X Unity project...
git clone https://github.com/YOUR-USERNAME/NeuraUnityMobile.git
cd NeuraUnityMobile

:: Install Newtonsoft.Json via Unity package manager
echo [📦] Installing Newtonsoft.Json...
mkdir Packages
echo { > Packages/manifest.json
echo   "dependencies": { >> Packages/manifest.json
echo     "com.unity.nuget.newtonsoft-json": "3.0.2" >> Packages/manifest.json
echo   } >> Packages/manifest.json
echo } >> Packages/manifest.json

:: Prompt for API Keys
set /p OPENAI_KEY=Enter your OpenAI API Key: 
set /p GOOGLE_KEY=Enter your Google Cloud TTS API Key: 

:: Write to config file
echo [🔐] Saving API keys...
mkdir Assets\Neura\Scripts
(
echo static class NeuraConfig {
echo     public const string OPENAI_API_KEY = "%OPENAI_KEY%";
echo     public const string GOOGLE_TTS_API_KEY = "%GOOGLE_KEY%";
echo }
) > Assets\Neura\Scripts\NeuraConfig.cs

echo [✅] Setup Complete. Open the project in Unity Hub or Editor.

pause
