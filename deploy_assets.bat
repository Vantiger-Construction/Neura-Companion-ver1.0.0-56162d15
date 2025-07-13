@echo off
set SRC=assets_final\animations
set DST=packages\core\assets\animations
echo Cleaning old placeholders...
del /Q "%DST%\*" 
if not exist "%DST%" mkdir "%DST%"
echo Copying final assets...
xcopy "%SRC%\*" "%DST%\" /E /I /Y
echo Assets deployed to %DST%
pause
