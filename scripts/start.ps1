# Check if another instance is running and stop it first
$procs = Get-CimInstance Win32_Process -Filter "Name = 'node.exe'" | Where-Object {
    $_.CommandLine -match 'watchdog\.js' -or $_.CommandLine -match 'src[/\\]index\.js'
}

if ($procs) {
    Write-Host "[*] Stopping previous bot instances..." -ForegroundColor Yellow
    foreach ($p in $procs) {
        Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
    }
    Start-Sleep -Seconds 1
}

$projectDir = Split-Path -Parent $PSScriptRoot
Write-Host "[+] Starting Antigravity Bot watchdog..." -ForegroundColor Cyan

Start-Process node -ArgumentList 'src/watchdog.js' -WindowStyle Hidden -WorkingDirectory $projectDir

Start-Sleep -Seconds 2

# Verify it started
$newProcs = Get-CimInstance Win32_Process -Filter "Name = 'node.exe'" | Where-Object {
    $_.CommandLine -match 'watchdog\.js'
}

if ($newProcs) {
    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Green
    Write-Host "  Antigravity Bot is now running in the background!       " -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Green
    Write-Host "  Telegram Bot: Active" -ForegroundColor White
    Write-Host "  To stop: Run stop_bot.bat" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "[-] Failed to start bot. Run 'npm start' to view error logs." -ForegroundColor Red
}
