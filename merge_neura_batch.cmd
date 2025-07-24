@echo off
setlocal enabledelayedexpansion

:: Define root destination folder on Z: drive
set DEST=Z:\Neura_Companion_Complete
set TEMPZIP=%DEST%\temp_zip
set PROG=%DEST%\progress.log

:: Ensure destination and temp folders exist
mkdir "%TEMPZIP%" 2>nul
mkdir "%DEST%" 2>nul

:: Initialize counters
set total=0
set current=0

:: Count total ZIP files first
for /R "Z:\" %%Z in (*.zip) do set /A total+=1

echo Scanning and processing ZIP files...

:: Load progress if exists
set lastProcessed=0
if exist "%PROG%" (
    set /p lastProcessed=<"%PROG%"
    echo Resuming from ZIP #!lastProcessed!...
)

:: Process ZIP files
for /R "Z:\" %%Z in (*.zip) do (
    set /A current+=1
    if !current! GTR !lastProcessed! (
        echo ----------------------------------------------
        echo Processing (!current!/!total!): %%~nxZ
        powershell -nologo -noprofile -command "Expand-Archive -Force '%%Z' '%TEMPZIP%'"

        for /R "%TEMPZIP%" %%F in (*) do (
            set EXT=%%~xF
            set NAME=%%~nxF

            if /I "!EXT!"==".dart" (
                mkdir "%DEST%\lib" >nul 2>&1
                move /Y "%%F" "%DEST%\lib\" >nul
            ) else if /I "!NAME!"=="main.dart" (
                move /Y "%%F" "%DEST%\" >nul
            ) else if /I "!NAME!"=="pubspec.yaml" (
                move /Y "%%F" "%DEST%\" >nul
            ) else if "!EXT!"==".mp3" "!EXT!"==".wav" "!EXT!"==".ogg" (
                mkdir "%DEST%\assets\audio" >nul 2>&1
                move /Y "%%F" "%DEST%\assets\audio\" >nul
            ) else if "!EXT!"==".png" "!EXT!"==".jpg" "!EXT!"==".svg" "!EXT!"==".gif" (
                mkdir "%DEST%\assets\images" >nul 2>&1
                move /Y "%%F" "%DEST%\assets\images\" >nul
            ) else if "!EXT!"==".json" (
                mkdir "%DEST%\assets\data" >nul 2>&1
                move /Y "%%F" "%DEST%\assets\data\" >nul
            ) else if "!EXT!"==".txt" "!EXT!"==".csv" (
                mkdir "%DEST%\assets\text" >nul 2>&1
                move /Y "%%F" "%DEST%\assets\text\" >nul
            ) else if "!EXT!"==".lottie" "!EXT!"==".riv" "!EXT!"==".anim" (
                mkdir "%DEST%\assets\animations" >nul 2>&1
                move /Y "%%F" "%DEST%\assets\animations\" >nul
            ) else if "!EXT!"==".bat" "!EXT!"==".cmd" "!EXT!"==".sh" (
                mkdir "%DEST%\scripts" >nul 2>&1
                move /Y "%%F" "%DEST%\scripts\" >nul
            ) else if "!EXT!"==".onnx" "!EXT!"==".tflite" "!EXT!"==".bin" (
                mkdir "%DEST%\ai\models" >nul 2>&1
                move /Y "%%F" "%DEST%\ai\models\" >nul
            ) else if "!NAME!"=="README.md" "!NAME!"=="LICENSE" (
                mkdir "%DEST%\docs" >nul 2>&1
                move /Y "%%F" "%DEST%\docs\" >nul
            ) else (
                echo Unmatched file: %%F
            )
        )

        :: Clean up temp folder after each ZIP
        rmdir /S /Q "%TEMPZIP%" >nul
        mkdir "%TEMPZIP%" >nul

        :: Save progress
        > "%PROG%" echo !current!
        echo Completed ZIP #!current! of !total!.
    ) else (
        echo Skipping ZIP #!current! (already processed).
    )
)

echo --------------------------------------------------
echo All ZIP files processed and merged into:
echo %DEST%
echo --------------------------------------------------
pause