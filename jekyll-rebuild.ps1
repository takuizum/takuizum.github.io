# Jekyll 完全リビルド＆起動スクリプト (PowerShell版)
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Jekyll 完全リビルド＆起動スクリプト" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: 既存プロセス終了
Write-Host "[1/5] 既存のJekyllプロセスを終了中..." -ForegroundColor Yellow
Get-Process ruby* -ErrorAction SilentlyContinue | Stop-Process -Force
$procs = netstat -ano | Select-String ":4000" | ForEach-Object { ($_ -split "\s+")[4] } | Where-Object { $_ -match "^\d+$" }
foreach ($proc in $procs) {
    Stop-Process -Id $proc -Force -ErrorAction SilentlyContinue
    Write-Host "  プロセス $proc を終了しました" -ForegroundColor Gray
}
Write-Host "  プロセス終了完了" -ForegroundColor Green
Write-Host ""

# Step 2: ビルドキャッシュクリア
Write-Host "[2/5] ビルドキャッシュをクリア中..." -ForegroundColor Yellow
if (Test-Path "_site") {
    Remove-Item "_site" -Recurse -Force
    Write-Host "  ビルドキャッシュをクリアしました" -ForegroundColor Green
} else {
    Write-Host "  ビルドキャッシュは既にクリアされています" -ForegroundColor Green
}
Write-Host ""

# Step 3: 完全リビルド
Write-Host "[3/5] サイトを完全リビルド中..." -ForegroundColor Yellow
& C:\Ruby34-x64\bin\jekyll.bat build
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ エラー: ビルドに失敗しました" -ForegroundColor Red
    Write-Host "詳細なエラー情報を確認してください" -ForegroundColor Red
    Read-Host "何かキーを押して終了"
    exit 1
}
Write-Host "  ✅ ビルド完了" -ForegroundColor Green
Write-Host ""

# Step 4: サーバー起動
Write-Host "[4/5] サーバー起動中..." -ForegroundColor Yellow
$job = Start-Job -ScriptBlock {
    Set-Location $using:PWD
    & C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental --host 0.0.0.0 --port 4000
}
Write-Host "  サーバーをバックグラウンドで起動しました (Job ID: $($job.Id))" -ForegroundColor Green

# Step 5: 起動確認とブラウザ起動
Write-Host "[5/5] サーバーの起動を確認中..." -ForegroundColor Yellow
$maxWait = 10
$waited = 0
do {
    Start-Sleep -Seconds 1
    $waited++
    $serverRunning = netstat -ano | Select-String ":4000"
    Write-Host "  待機中... ($waited/$maxWait 秒)" -ForegroundColor Gray
} while (-not $serverRunning -and $waited -lt $maxWait)

if ($serverRunning) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "🚀 Jekyll開発環境が準備完了しました！" -ForegroundColor Green
    Write-Host "📱 URL: http://localhost:4000" -ForegroundColor Green
    Write-Host "🔄 ライブリロード: 有効" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    
    # VS Code Simple Browser で開く
    Write-Host "VS Code Simple Browser でサイトを開いています..." -ForegroundColor Cyan
    & code --command "simpleBrowser.show" "http://localhost:4000"
    
    Write-Host ""
    Write-Host "サーバーは ID $($job.Id) で動作しています" -ForegroundColor Yellow
    Write-Host "停止するには: Stop-Job $($job.Id); Remove-Job $($job.Id)" -ForegroundColor Yellow
    
} else {
    Write-Host "❌ エラー: サーバーの起動に失敗しました" -ForegroundColor Red
    Write-Host "手動で起動してください:" -ForegroundColor Yellow
    Write-Host "C:\Ruby34-x64\bin\jekyll.bat serve --livereload --incremental" -ForegroundColor White
    Stop-Job $job -ErrorAction SilentlyContinue
    Remove-Job $job -ErrorAction SilentlyContinue
}

Write-Host ""
Read-Host "何かキーを押して終了"
