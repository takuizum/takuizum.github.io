@echo off
echo ========================================
echo Jekyll Quick Debug Start
echo ========================================
echo.

echo [DEBUG] Current directory: %CD%
echo [DEBUG] Date/Time: %DATE% %TIME%
echo.

REM Kill existing processes
echo [1/4] Killing existing processes...
taskkill /F /IM ruby.exe >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano 2^>nul ^| findstr :4000') do taskkill /F /PID %%a >nul 2>&1
echo Process cleanup completed
echo.

REM Clean build
echo [2/4] Cleaning build cache...
if exist "_site" rmdir /S /Q "_site" >nul 2>&1
echo Cache cleaned
echo.

REM Build
echo [3/4] Building site...
C:\Ruby34-x64\bin\jekyll.bat build
echo Build completed with exit code: %ERRORLEVEL%
echo.

REM Start server and show output immediately
echo [4/4] Starting server...
echo.
echo ========================================
echo Starting Jekyll Server...
echo URLs will be displayed when ready:
echo   Local:   http://localhost:4000
echo   Network: http://0.0.0.0:4000
echo ========================================
echo.

REM Start server with immediate output
C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental --host 0.0.0.0 --port 4000

echo.
echo Server stopped or failed to start
pause
