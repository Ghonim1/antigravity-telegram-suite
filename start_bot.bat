@echo off
title Antigravity Telegram Suite
cd /d "%~dp0"

echo ========================================================
echo   Antigravity Bot Starter
echo ========================================================
echo.

:: 1. Stop any old/stuck node bot instances first
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\stop.ps1"

echo.
echo Starting Antigravity Bot...
echo Keep this window open (or minimized) while using the bot.
echo Press Ctrl+C to stop.
echo ========================================================
echo.

node src/index.js
pause
