@echo off
echo 💠 Running Neura Companion Installer...

:: Download latest installer
curl -L -o NeuraCompanion.exe https://yourdomain.com/downloads/Neura_Companion_Test.exe

:: Run installer with elevated permissions
powershell -Command "Start-Process 'NeuraCompanion.exe' -Verb runAs"

:: Allow firewall access
netsh advfirewall firewall add rule name="Neura Companion" dir=in action=allow program="%ProgramFiles%\NeuraCompanion\NeuraCompanion.exe" enable=yes

echo ✅ Installation and firewall approval complete.
pause
