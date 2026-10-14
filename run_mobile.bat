@echo off
REM Starts SmartPack AI so other devices on the same private network can open it.
cd /d "%~dp0"
if not exist venv (
  echo Run setup.bat first.
  pause
  exit /b 1
)
call venv\Scripts\activate
set "HOST=0.0.0.0"
set "DEBUG=0"
cd backend
echo SmartPack AI is starting for devices on your private Wi-Fi.
echo On this PC, open http://localhost:5000
echo On your phone, open http://PC-IP-ADDRESS:5000
echo Find the PC IPv4 address by running ipconfig in another terminal.
echo Keep this window open while using the app. Press Ctrl+C to stop it.
python app.py
pause
