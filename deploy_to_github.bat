@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Set repo details
set REPO_DIR=neura-companion-microsite
set USERNAME=Vantiger1
set REPO_URL=https://github.com/!USERNAME!/!REPO_DIR!.git
set BRANCH=gh-pages

:: Clean old repo clone
IF EXIST "!REPO_DIR!" (
    rmdir /S /Q "!REPO_DIR!"
)

:: Clone or init repo
git clone !REPO_URL! || (
    mkdir "!REPO_DIR!"
    cd "!REPO_DIR!"
    git init
    git remote add origin !REPO_URL!
    cd ..
)

:: Change directory to repo
cd "!REPO_DIR!"

:: Checkout or create gh-pages branch
git checkout !BRANCH! 2>nul || git checkout -b !BRANCH!

:: Clean old files
del /Q *.* >nul 2>&1
for /d %%x in (*) do rmdir /s /q "%%x"

:: Copy new site files
xcopy /E /I /Y ..\neura_microsite_embed\*.* .

:: Commit and push
git add .
git commit -m "🚀 Deployed updated Neura Companion microsite"
git push origin !BRANCH!

echo Deployment complete.
pause
