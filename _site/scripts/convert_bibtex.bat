@echo off
REM BibTeX to Markdown Converter (Windows Batch)
REM 使用方法: convert_bibtex.bat bibliography.bib

if "%1"=="" (
    echo Usage: convert_bibtex.bat ^<bibtex_file^> [output_dir]
    echo Example: convert_bibtex.bat _bibliography\references.bib
    exit /b 1
)

set BIBTEX_FILE=%1
set OUTPUT_DIR=%2
if "%OUTPUT_DIR%"=="" set OUTPUT_DIR=_publications

echo Converting %BIBTEX_FILE% to Jekyll publications...

REM 出力ディレクトリ内の既存のMarkdownファイルを削除
echo Cleaning up existing Markdown files in %OUTPUT_DIR%...
if exist "%OUTPUT_DIR%\*.md" (
    del /q "%OUTPUT_DIR%\*.md"
    echo Deleted existing .md files in %OUTPUT_DIR%
) else (
    echo No existing .md files found in %OUTPUT_DIR%
)

REM 出力ディレクトリが存在しない場合は作成
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
    echo Created directory %OUTPUT_DIR%
)

REM Pythonバージョンを試す（--cleanオプション付き）
python scripts\bibtex_converter.py "%BIBTEX_FILE%" --output-dir "%OUTPUT_DIR%" --clean %3 %4 %5
if %ERRORLEVEL% EQU 0 (
    echo Conversion completed successfully!
    exit /b 0
)

REM Pythonが失敗した場合、Juliaバージョンを試す（--cleanオプション付き）
echo Python version failed, trying Julia version...
julia scripts\bibtex_converter.jl "%BIBTEX_FILE%" --output-dir "%OUTPUT_DIR%" --clean %3 %4 %5
if %ERRORLEVEL% EQU 0 (
    echo Conversion completed successfully with Julia!
    exit /b 0
)

echo Both Python and Julia converters failed. Please check your installation.
exit /b 1
