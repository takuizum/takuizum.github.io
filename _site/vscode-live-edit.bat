@echo off
echo ========================================
echo VS Code ライブエディット環境起動
echo ========================================
echo.

REM ポートクリア
echo [1/3] ポートをクリア中...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :4000') do taskkill /F /PID %%a >nul 2>&1
taskkill /F /IM ruby.exe >nul 2>&1

REM VS Code でプロジェクトを開く
echo [2/3] VS Code でプロジェクトを開いています...
code . 

REM 少し待ってからサーバー起動
echo [3/3] 3秒後にJekyllサーバーを起動します...
timeout /t 3 /nobreak >nul

echo サーバー起動中...
echo VS Code で Ctrl+Shift+P → "Simple Browser: Show" → "http://localhost:4000"
echo.

C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental
