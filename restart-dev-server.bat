@echo off
echo ========================================
echo Jekyll 開発サーバー再起動スクリプト
echo ========================================
echo.

REM 現在のディレクトリを確認
echo 現在のディレクトリ: %CD%
echo.

REM ポート4000を使用しているプロセスを終了
echo [1/4] ポート4000使用中のプロセスを終了しています...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :4000') do (
    echo プロセスID %%a を終了中...
    taskkill /F /PID %%a >nul 2>&1
)
echo ポートクリア完了
echo.

REM Rubyプロセスも念のため終了
echo [2/4] Jekyll関連プロセスを終了しています...
taskkill /F /IM ruby.exe >nul 2>&1
taskkill /F /IM jekyll.exe >nul 2>&1
echo プロセス終了完了
echo.

REM サイトを再ビルド
echo [3/4] サイトを再ビルドしています...
C:\Ruby34-x64\bin\jekyll.bat build
if %ERRORLEVEL% neq 0 (
    echo エラー: ビルドに失敗しました
    pause
    exit /b 1
)
echo ビルド完了
echo.

REM 開発サーバーを起動
echo [4/4] 開発サーバーを起動しています...
echo.
echo ========================================
echo サーバー起動中...
echo ブラウザで http://localhost:4000 を開いてください
echo 終了するには Ctrl+C を押してください
echo ========================================
echo.

C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental --host 0.0.0.0 --port 4000

echo.
echo サーバーが停止しました
pause
