@echo off
REM -------------------------------------------------
REM Package Neura Engine Project
REM -------------------------------------------------
SETLOCAL

REM Remove old staging folder if it exists
IF EXIST neura_package (
    rd /s /q neura_package
)

REM Create staging directory
mkdir neura_package

REM Copy source code
xcopy src neura_package\src /E /I /Y

REM Copy headers
xcopy include neura_package\include /E /I /Y

REM Copy CMakeLists and scripts/configs
copy CMakeLists.txt neura_package\ /Y
xcopy scripts neura_package\scripts /E /I /Y
xcopy configs neura_package\configs /E /I /Y
xcopy plugins neura_package\plugins /E /I /Y
xcopy tests neura_package\tests /E /I /Y

REM Create the zip using PowerShell
powershell -Command "if (Test-Path 'neura_engine_package.zip') { Remove-Item 'neura_engine_package.zip' }"
powershell -Command "Compress-Archive -Path neura_package -DestinationPath neura_engine_package.zip -Force"

echo.
echo Package created: neura_engine_package.zip
echo.

ENDLOCAL
