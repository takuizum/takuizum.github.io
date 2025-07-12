# Jekyll Development Environment Setup for Windows
# このスクリプトを実行してPowerShell Profileを設定します

Write-Host "Setting up Jekyll Development Environment..." -ForegroundColor Cyan

# PowerShell Profile の設定
$profileContent = @'
# Jekyll Development Environment for Windows
$env:LANG = "en_US.UTF-8"
$env:LC_ALL = "en_US.UTF-8"
$env:JEKYLL_ENV = "development"

# Jekyll エイリアス
function jserve { bundle exec jekyll serve --livereload --incremental }
function jbuild { bundle exec jekyll build }
function jdraft { bundle exec jekyll serve --livereload --drafts --incremental }
function jclean { bundle exec jekyll clean }
function jopen { Start-Process "http://localhost:4000" }

# Git エイリアス
function gst { git status }
function gaa { git add . }
function gcm { param($msg) git commit -m $msg }
function gps { git push }
function gpl { git pull }

# Bundle/npm エイリアス
function bi { bundle install }
function ni { npm install }

Write-Host "Jekyll Development Environment Loaded!" -ForegroundColor Green
'@

# PowerShell Profile に設定を追加
Write-Host "Adding Jekyll commands to PowerShell Profile..." -ForegroundColor Yellow

if (Test-Path $PROFILE) {
    $existingContent = Get-Content $PROFILE -Raw
    if ($existingContent -notlike "*Jekyll Development Environment*") {
        Add-Content $PROFILE "`n$profileContent"
        Write-Host "Jekyll settings added to existing profile" -ForegroundColor Green
    } else {
        Write-Host "Jekyll settings already exist in profile" -ForegroundColor Yellow
    }
} else {
    New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force | Out-Null
    Set-Content $PROFILE $profileContent
    Write-Host "New PowerShell profile created with Jekyll settings" -ForegroundColor Green
}

Write-Host "`nProfile location: $PROFILE" -ForegroundColor Cyan

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Restart PowerShell or run: . `$PROFILE" -ForegroundColor White
Write-Host "2. Run: Jekyll-Dev-Setup (or manually run 'bundle install' then 'npm install')" -ForegroundColor White
Write-Host "3. Run: jserve (to start development server)" -ForegroundColor White
Write-Host "4. Open http://localhost:4000 in your browser" -ForegroundColor White

Write-Host "`nAvailable commands after setup:" -ForegroundColor Cyan
Write-Host "  jserve  - Start Jekyll development server" -ForegroundColor White
Write-Host "  jbuild  - Build Jekyll site" -ForegroundColor White
Write-Host "  jdraft  - Serve with drafts" -ForegroundColor White
Write-Host "  jclean  - Clean Jekyll site" -ForegroundColor White
Write-Host "  jopen   - Open site in browser" -ForegroundColor White
