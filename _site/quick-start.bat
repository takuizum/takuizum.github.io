@echo off
echo ========================================
echo Jekyll クイック起動スクリプト
echo ========================================
echo.

REM ポート4000をクリア
echo ポートをクリア中...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :4000') do taskkill /F /PID %%a >nul 2>&1
taskkill /F /IM ruby.exe >nul 2>&1

REM サーバー起動
echo サーバーを起動中...
echo ブラウザで http://localhost:4000 を開いてください
echo.

C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental
