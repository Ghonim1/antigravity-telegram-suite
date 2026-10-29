@echo off
title Antigravity Bot (Watchdog Mode)
cd /d "%~dp0"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\stop.ps1"
echo Starting Watchdog...
node src/watchdog.js
pause
