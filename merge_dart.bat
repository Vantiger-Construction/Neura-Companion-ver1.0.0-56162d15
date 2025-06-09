@echo off
REM Merge all Dart files into combined.dart
pushd "%~dp0"
setlocal EnableDelayedExpansion
set "output=lib\combined.dart"
if exist "%output%" del "%output%"
for /R "lib" %%f in (*.dart) do (
    if /I not "%%~nxf"=="combined.dart" (
        echo // --- Begin %%f --->>"%output%"
        type "%%f">>"%output%"
        echo.>>"%output%"
    )
)
echo All Dart files merged into %output%
endlocal
popd
pause
