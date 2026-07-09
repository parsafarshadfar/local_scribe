@echo off
title Meeting Assistant Background Server

:: Port for the local server
set PORT=8000
set URL=http://localhost:%PORT%/meeting_assistant.html

:: Try to open as a standalone app window in Chrome or Edge
start chrome --app="%URL%" 2>nul || start msedge --app="%URL%" 2>nul || start "" "%URL%"

:: Keep this window minimized so the user can close it later
echo ===================================================
echo  Meeting Assistant is running!
echo  This background window keeps the app working.
echo  You can safely minimize it. Close it to stop.
echo ===================================================
echo.

:: 1. Try Python 3
where python >nul 2>nul
if %ERRORLEVEL% == 0 (
    python -m http.server %PORT%
    exit
)
where python3 >nul 2>nul
if %ERRORLEVEL% == 0 (
    python3 -m http.server %PORT%
    exit
)

:: 2. Try Node.js
where npx >nul 2>nul
if %ERRORLEVEL% == 0 (
    npx -y http-server -p %PORT% -c-1
    exit
)

:: 3. Fallback to PowerShell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://localhost:%PORT%/'); $listener.Start(); Write-Host 'Server running...'; $root = (Get-Location).Path; while ($listener.IsListening) { $ctx = $listener.GetContext(); $req = $ctx.Request; $resp = $ctx.Response; $path = $req.Url.LocalPath; if ($path -eq '/') { $path = '/meeting_assistant.html'; } $file = Join-Path $root $path.TrimStart('/'); if (Test-Path $file) { $bytes = [System.IO.File]::ReadAllBytes($file); $ext = [System.IO.Path]::GetExtension($file).ToLower(); switch ($ext) { '.html' { $resp.ContentType = 'text/html; charset=utf-8' } '.json' { $resp.ContentType = 'application/json; charset=utf-8' } '.js' { $resp.ContentType = 'application/javascript; charset=utf-8' } default { $resp.ContentType = 'application/octet-stream' } }; $resp.ContentLength64 = $bytes.Length; $resp.OutputStream.Write($bytes, 0, $bytes.Length); } else { $resp.StatusCode = 404; $bytes = [System.Text.Encoding]::UTF8.GetBytes('Not Found'); $resp.OutputStream.Write($bytes, 0, $bytes.Length); }; $resp.Close(); }"
