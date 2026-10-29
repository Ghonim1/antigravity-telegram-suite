Write-Host "Stopping Antigravity Bot and Watchdog..." -ForegroundColor Yellow

$procs = Get-CimInstance Win32_Process -Filter "Name = 'node.exe'" | Where-Object {
    $_.CommandLine -match 'watchdog\.js' -or $_.CommandLine -match 'src[/\\]index\.js'
}

if ($procs) {
    foreach ($p in $procs) {
        Write-Host "Stopping process PID $($p.ProcessId)..." -ForegroundColor Cyan
        Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
    }
    Write-Host "[+] All Antigravity Bot processes stopped successfully." -ForegroundColor Green
} else {
    Write-Host "[i] No running Antigravity Bot processes found." -ForegroundColor Gray
}
