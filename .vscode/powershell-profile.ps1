# PowerShell Profile for Jekyll Development
# このファイルを $PROFILE にコピーするか、内容を追加してください

# Jekyll 開発用エイリアス
function Jekyll-Serve {
    Write-Host "Starting Jekyll development server..." -ForegroundColor Green
    bundle exec jekyll serve --livereload --incremental
}
Set-Alias jserve Jekyll-Serve

function Jekyll-Build {
    Write-Host "Building Jekyll site for production..." -ForegroundColor Green
    $env:JEKYLL_ENV = "production"
    bundle exec jekyll build
}
Set-Alias jbuild Jekyll-Build

function Jekyll-Serve-Draft {
    Write-Host "Starting Jekyll with drafts..." -ForegroundColor Green
    bundle exec jekyll serve --livereload --drafts --incremental
}
Set-Alias jdraft Jekyll-Serve-Draft

function Jekyll-Clean {
    Write-Host "Cleaning Jekyll site..." -ForegroundColor Green
    bundle exec jekyll clean
}
Set-Alias jclean Jekyll-Clean

# Git 開発用エイリアス
function Git-Status { git status $args }
Set-Alias gst Git-Status

function Git-Checkout { git checkout $args }
Set-Alias gco Git-Checkout

function Git-Commit { git commit -m $args }
Set-Alias gcm Git-Commit

function Git-Push { git push $args }
Set-Alias gps Git-Push

function Git-Pull { git pull $args }
Set-Alias gpl Git-Pull

function Git-Add-All { git add . }
Set-Alias gaa Git-Add-All

function Git-Log-Pretty { git log --oneline --graph --decorate $args }
Set-Alias glog Git-Log-Pretty

# npm/yarn エイリアス
function Npm-Install { npm install $args }
Set-Alias ni Npm-Install

function Npm-Run { npm run $args }
Set-Alias nr Npm-Run

function Npm-Start { npm start }
Set-Alias ns Npm-Start

function Npm-Test { npm test }
Set-Alias nt Npm-Test

# Bundle エイリアス
function Bundle-Install { bundle install $args }
Set-Alias bi Bundle-Install

function Bundle-Update { bundle update $args }
Set-Alias bu Bundle-Update

function Bundle-Exec { bundle exec $args }
Set-Alias be Bundle-Exec

# 便利な開発関数
function New-Jekyll-Post {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title
    )
    
    $date = Get-Date -Format "yyyy-MM-dd"
    $slug = $Title.ToLower() -replace '[^a-z0-9\s]', '' -replace '\s+', '-'
    $filename = "_posts/$date-$slug.md"
    
    $content = @"
---
layout: post
title: "$Title"
date: $date
categories: []
tags: []
excerpt: ""
---

Write your post content here...
"@
    
    New-Item -Path $filename -ItemType File -Value $content -Force
    Write-Host "Created new post: $filename" -ForegroundColor Green
    code $filename
}

function New-Jekyll-Publication {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title
    )
    
    $slug = $Title.ToLower() -replace '[^a-z0-9\s]', '' -replace '\s+', '-'
    $filename = "_publications/$slug.md"
    
    $content = @"
---
title: "$Title"
authors: ""
journal: ""
year: $(Get-Date -Format 'yyyy')
volume: ""
pages: ""
doi: ""
pdf_url: ""
abstract: |
  Abstract text here...
tags: [research, publication]
---

Additional content...
"@
    
    New-Item -Path $filename -ItemType File -Value $content -Force
    Write-Host "Created new publication: $filename" -ForegroundColor Green
    code $filename
}

function Open-Jekyll-Site {
    Start-Process "http://localhost:4000"
}
Set-Alias jopen Open-Jekyll-Site

function Jekyll-Dev-Setup {
    Write-Host "Setting up Jekyll development environment..." -ForegroundColor Cyan
    
    # Bundle install
    Write-Host "Installing Ruby gems..." -ForegroundColor Yellow
    bundle install
    
    # npm install
    Write-Host "Installing npm packages..." -ForegroundColor Yellow
    npm install
    
    # Create necessary directories
    $dirs = @("_drafts", "assets/images", "assets/pdf")
    foreach ($dir in $dirs) {
        if (-not (Test-Path $dir)) {
            New-Item -Path $dir -ItemType Directory -Force
            Write-Host "Created directory: $dir" -ForegroundColor Green
        }
    }
    
    Write-Host "Development environment setup complete!" -ForegroundColor Green
    Write-Host "Run 'jserve' to start the development server" -ForegroundColor Cyan
}

# 環境変数設定
$env:JEKYLL_ENV = "development"
$env:LANG = "en_US.UTF-8"
$env:LC_ALL = "en_US.UTF-8"

# PowerShell の見た目を改善
if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git
}

# 起動メッセージ
Write-Host "Jekyll Development Environment Loaded" -ForegroundColor Green
Write-Host "Available commands:" -ForegroundColor Cyan
Write-Host "  jserve  - Start Jekyll development server" -ForegroundColor White
Write-Host "  jbuild  - Build Jekyll site" -ForegroundColor White
Write-Host "  jdraft  - Serve with drafts" -ForegroundColor White
Write-Host "  jclean  - Clean Jekyll site" -ForegroundColor White
Write-Host "  jopen   - Open site in browser" -ForegroundColor White
Write-Host "  Jekyll-Dev-Setup - Setup development environment" -ForegroundColor White
Write-Host ""
