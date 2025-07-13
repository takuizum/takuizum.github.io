# Jekyll 開発用 PowerShell 関数

# 完全再起動関数
function Restart-Jekyll {
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Jekyll 開発サーバー再起動" -ForegroundColor Cyan  
    Write-Host "========================================" -ForegroundColor Cyan
    
    # ポートクリア
    Write-Host "[1/4] ポート4000をクリア中..." -ForegroundColor Yellow
    Get-Process ruby* -ErrorAction SilentlyContinue | Stop-Process -Force
    $procs = netstat -ano | Select-String ":4000" | ForEach-Object { ($_ -split "\s+")[4] } | Where-Object { $_ -match "^\d+$" }
    foreach ($proc in $procs) {
        Stop-Process -Id $proc -Force -ErrorAction SilentlyContinue
    }
    
    # ビルド
    Write-Host "[2/4] サイト再ビルド中..." -ForegroundColor Yellow
    C:\Ruby34-x64\bin\jekyll.bat build
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "エラー: ビルドに失敗しました" -ForegroundColor Red
        return
    }
    
    # サーバー起動
    Write-Host "[3/4] サーバー起動中..." -ForegroundColor Yellow
    Write-Host "ブラウザで http://localhost:4000 を開いてください" -ForegroundColor Green
    C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental
}

# クイック起動関数
function Start-JekyllQuick {
    Write-Host "Jekyll クイック起動中..." -ForegroundColor Cyan
    
    # ポートクリア
    Get-Process ruby* -ErrorAction SilentlyContinue | Stop-Process -Force
    $procs = netstat -ano | Select-String ":4000" | ForEach-Object { ($_ -split "\s+")[4] } | Where-Object { $_ -match "^\d+$" }
    foreach ($proc in $procs) {
        Stop-Process -Id $proc -Force -ErrorAction SilentlyContinue
    }
    
    # サーバー起動
    Write-Host "サーバー起動中..." -ForegroundColor Green
    C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental
}

# VS Code + Jekyll 起動関数
function Start-JekyllWithVSCode {
    Write-Host "VS Code ライブエディット環境起動中..." -ForegroundColor Cyan
    
    # ポートクリア
    Get-Process ruby* -ErrorAction SilentlyContinue | Stop-Process -Force
    
    # VS Code 起動
    code .
    
    # 少し待機
    Start-Sleep -Seconds 2
    
    # サーバー起動
    Write-Host "VS Code で Ctrl+Shift+P → 'Simple Browser: Show' → 'http://localhost:4000'" -ForegroundColor Yellow
    C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental
}

# エイリアス設定
Set-Alias jr Restart-Jekyll
Set-Alias jq Start-JekyllQuick  
Set-Alias jv Start-JekyllWithVSCode

Write-Host "Jekyll 開発用関数が読み込まれました:" -ForegroundColor Green
Write-Host "  jr  - Jekyll 完全再起動" -ForegroundColor White
Write-Host "  jq  - Jekyll クイック起動" -ForegroundColor White  
Write-Host "  jv  - VS Code + Jekyll 起動" -ForegroundColor White
