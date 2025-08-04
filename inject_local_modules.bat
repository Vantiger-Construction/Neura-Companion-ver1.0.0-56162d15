@echo off
echo [NEURA LOCAL MODULE INJECTOR]
echo Injecting Firebase replacement modules into Neura Companion source tree...

REM Set base destination path for Neura Companion source
set "DEST=Z:\Neura-Companion\lib\core\firebase_replacement"

REM Create destination directory if it doesn't exist
if not exist "%DEST%" mkdir "%DEST%"

REM Copy all replacement Dart files to project
copy "/mnt/data/Neura_Local_Module_Replacement\*.dart" "%DEST%"

echo.
echo ✅ Modules injected into %DEST%
echo.
pause
