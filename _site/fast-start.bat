@echo off
REM Fast Jekyll startup script
REM Author: PsyTestLab
REM Version: 2.0 - Simplified approach

echo ===================================================
echo   PsyTestLab Jekyll Fast Startup
echo ===================================================
echo.

REM Stop any running Jekyll servers
echo Cleaning up running servers...
taskkill /f /im "ruby.exe" >nul 2>&1

REM Wait a moment
timeout /t 2 /nobreak >nul

REM Start Jekyll server in background
echo Starting Jekyll development server...
echo.
start /b C:\Ruby34-x64\bin\bundle.bat exec jekyll serve --incremental --livereload --force_polling

REM Give it time to start
echo Please wait - starting server...
timeout /t 8 /nobreak >nul

REM Show URL immediately
echo.
echo *** SERVER READY ***
echo.
echo Click here to open: http://127.0.0.1:4000/
echo VS Code Browser: http://localhost:4000/
echo.
echo Server is running in background
echo Press Ctrl+C to stop the server
echo.

REM Keep window open
pause
