@echo off
echo ========================================
echo Jekyll Complete Rebuild and Start
echo ========================================
echo.

REM Display current directory
echo Working Directory: %CD%
echo.

REM Step 1: Terminate existing Jekyll processes
echo [1/5] Terminating existing Jekyll processes...
taskkill /F /IM ruby.exe >nul 2>&1
taskkill /F /IM jekyll.exe >nul 2>&1

REM Terminate processes using port 4000
for /f "tokens=5" %%a in ('netstat -ano 2^>nul ^| findstr :4000') do (
    echo Terminating port 4000 process %%a...
    taskkill /F /PID %%a >nul 2>&1
)
echo Process termination complete
echo.

REM Step 2: Clear _site folder for complete rebuild
echo [2/5] Clearing existing build files...
if exist "_site" (
    rmdir /S /Q "_site" >nul 2>&1
    echo Build cache cleared
) else (
    echo Build cache already cleared
)
echo.

REM Step 3: Execute complete rebuild
echo [3/5] Executing complete rebuild...
C:\Ruby34-x64\bin\jekyll.bat build
set BUILD_RESULT=%ERRORLEVEL%
echo Build exit code: %BUILD_RESULT%
if %BUILD_RESULT% neq 0 (
    echo.
    echo Error: Build failed with exit code %BUILD_RESULT%
    echo Please check error details above
    pause
    exit /b 1
)
echo Build completed successfully
echo.

REM Step 4: Check server status and start
echo [4/5] Starting server...
echo Starting server with live reload...
echo Open http://localhost:4000 in your browser
echo Press Ctrl+C to stop the server
echo.

REM Start server in background
echo Starting Jekyll server process...
start "Jekyll Server" C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental --host 0.0.0.0 --port 4000
echo Server start command executed
echo.

REM Step 5: Wait for server startup
echo [5/5] Waiting for server startup...
echo Waiting 3 seconds...
timeout /t 3 /nobreak >nul
echo Waiting 3 more seconds...
timeout /t 3 /nobreak >nul
echo Waiting 2 more seconds...
timeout /t 2 /nobreak >nul
echo Checking server status...

REM Check if server is running
echo Checking for server on port 4000...
netstat -ano | findstr :4000
set SERVER_CHECK=%ERRORLEVEL%
echo Server check exit code: %SERVER_CHECK%

REM Additional check for localhost
echo Checking localhost specifically...
netstat -ano | findstr 127.0.0.1:4000
set LOCALHOST_CHECK=%ERRORLEVEL%
echo Localhost check exit code: %LOCALHOST_CHECK%

if %SERVER_CHECK% equ 0 (
    echo.
    echo *** Server started successfully ***
    echo.
    echo *** Server started successfully ***
    echo.
    echo ========================================
    echo Jekyll development environment ready!
    echo ========================================
    echo.
    echo Local Server URLs:
    echo   Local:        http://localhost:4000
    echo   Network:      http://0.0.0.0:4000
    echo.
    echo Features:
    echo   Live reload:  Enabled
    echo   Incremental:  Enabled
    echo.
    echo Click the URL above to open in browser
    echo Or use Alt+Click in VS Code terminal
    echo ========================================
    echo.
    
    REM Open in VS Code Simple Browser
    echo Opening site in VS Code Simple Browser...
    code --command "simpleBrowser.show" --args "http://localhost:4000"
    
    echo.
    echo Server is running in separate window
    echo Server process: Jekyll Server
    echo Close Jekyll Server window to stop
    echo.
    echo Ready for development!
) else (
    echo.
    echo *** Server startup failed or still starting ***
    echo Checking for Jekyll Server window...
    tasklist | findstr ruby.exe
    echo.
    echo Manual startup command:
    echo C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental
    echo.
    echo If port 4000 is busy, try:
    echo C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental --port 4001
    echo.
    echo Tip: Check the Jekyll Server window for error messages
)

echo.
echo Press any key to exit...
pause >nul
