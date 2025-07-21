@echo off
REM -------------------------------------------------
REM Package Neura Engine Project (Windows)
REM -------------------------------------------------
SETLOCAL

REM Remove old staging folder if it exists
IF EXIST neura_package (
    rd /s /q neura_package
)

REM Create staging directory
mkdir neura_package

REM Copy everything you need
xcopy src neura_package\src /E /I /Y
xcopy include neura_package\include /E /I /Y
copy CMakeLists.txt neura_package\ /Y
xcopy scripts neura_package\scripts /E /I /Y
xcopy configs neura_package\configs /E /I /Y
xcopy plugins neura_package\plugins /E /I /Y
xcopy tests neura_package\tests /E /I /Y

REM Remove any old zip
if exist neura_engine_package.zip del /q neura_engine_package.zip

REM Create the zip via PowerShell
powershell -noprofile -command "Compress-Archive -Path neura_package\* -DestinationPath neura_engine_package.zip -Force"

echo.
echo *** Package created: neura_engine_package.zip ***
echo.

ENDLOCAL
