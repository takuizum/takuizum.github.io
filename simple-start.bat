@echo off
echo ========================================
echo Jekyll Simple Start (Fallback)
echo ========================================
echo.

REM Terminate processes
echo [1/3] Terminating existing processes...
taskkill /F /IM ruby.exe >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano 2^>nul ^| findstr :4000') do taskkill /F /PID %%a >nul 2>&1
timeout /t 2 /nobreak >nul

REM Start server
echo [2/3] Starting server...
start "Jekyll Server" cmd /c "cd /d %~dp0 && C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental --port 4000"

REM Wait for startup
echo [3/3] Waiting for startup...
timeout /t 5 /nobreak >nul

REM Check if server is running and display URLs
netstat -ano | findstr :4000 >nul
if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================
    echo Server started successfully!
    echo ========================================
    echo.
    echo Local Server URLs:
    echo   Local:        http://localhost:4000
    echo   Network:      http://0.0.0.0:4000
    echo.
    echo Click the URL above to open in browser
    echo Or use Alt+Click in VS Code terminal
    echo ========================================
    echo.
    
    REM Open browser
    echo Opening site in default browser...
    start http://localhost:4000
    
    echo Server is running in separate window
) else (
    echo Error: Server startup failed
    echo Please check the Jekyll Server window for errors
)

echo.
pause
