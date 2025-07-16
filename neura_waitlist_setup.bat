@echo off
REM --- Neura Companion Launch Prep Batch ---

REM Create Launch folder (Desktop path, change as needed)
set launchdir=%USERPROFILE%\Desktop\Neura_Launch
if not exist "%launchdir%" mkdir "%launchdir%"

REM Open the Launch folder
start "" "%launchdir%"

REM Open Google Forms for your waitlist
start "" "https://forms.google.com"

REM Open Tally.so for alternative waitlist form
start "" "https://tally.so"

REM Open Gmail ready to send invites
start "" "https://mail.google.com/"

echo.
echo Created 'Neura_Launch' folder on your Desktop!
echo Use Google Forms or Tally to make your waitlist form.
echo Drop your graphics, deck, and outreach files into this folder as you get them!
pause
