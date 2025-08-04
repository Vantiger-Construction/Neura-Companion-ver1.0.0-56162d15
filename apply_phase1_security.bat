@echo off
REM Batch script to automate Phase 1 security enhancements for Neura Companion

REM Configuration
set "REPO_URL=https://github.com/Vantiger1/Neura-Companion-ver1.0.0-56162d14.git"
set "REPO_DIR=Neura-Companion-ver1.0.0-56162d14"
set "PATCH_FILE=phase1-security.patch"

REM Check for Git
git --version >nul 2>&1
if errorlevel 1 (
  echo Git is not installed or not in PATH. Please install Git and retry.
  pause
  exit /b 1
)

REM Clone repository
echo Cloning repository...
git clone %REPO_URL% || (
  echo Failed to clone repository. Exiting.
  pause
  exit /b 1
)

cd %REPO_DIR%

REM Create new feature branch
echo Creating branch phase1-security...
git checkout -b phase1-security

REM Verify patch file exists
if not exist "..\%PATCH_FILE%" (
  echo Patch file "%PATCH_FILE%" not found in parent directory.
  echo Please place the patch file alongside this script and retry.
  pause
  exit /b 1
)

REM Apply the patch
echo Applying patch...
git apply "..\%PATCH_FILE%" || (
  echo Failed to apply patch. Check the patch file format.
  pause
  exit /b 1
)

REM Commit and push changes
echo Committing changes...
git add .
git commit -m "Phase1: Refresh tokens, roles, per-user rate limits, tightened CORS, input sanitization"

echo Pushing branch to remote...
git push -u origin phase1-security || (
  echo Failed to push branch. Check your remote permissions.
  pause
  exit /b 1
)

echo Phase 1 security enhancements apply complete.
pause
