#!/bin/bash
# BibTeX to Markdown Converter (Unix/Linux/macOS)
# 使用方法: ./convert_bibtex.sh bibliography.bib [output_dir]

if [ $# -eq 0 ]; then
    echo "Usage: $0 <bibtex_file> [output_dir]"
    echo "Example: $0 _bibliography/references.bib"
    exit 1
fi

BIBTEX_FILE="$1"
OUTPUT_DIR="${2:-_publications}"

echo "Converting $BIBTEX_FILE to Jekyll publications..."

# 出力ディレクトリ内の既存のMarkdownファイルを削除
echo "Cleaning up existing Markdown files in $OUTPUT_DIR..."
if [ -d "$OUTPUT_DIR" ] && [ "$(ls -A $OUTPUT_DIR/*.md 2>/dev/null)" ]; then
    rm -f "$OUTPUT_DIR"/*.md
    echo "Deleted existing .md files in $OUTPUT_DIR"
else
    echo "No existing .md files found in $OUTPUT_DIR"
fi

# 出力ディレクトリが存在しない場合は作成
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
    echo "Created directory $OUTPUT_DIR"
fi

# Pythonバージョンを試す（--cleanオプション付き）
if python3 scripts/bibtex_converter.py "$BIBTEX_FILE" --output-dir "$OUTPUT_DIR" --clean "${@:3}"; then
    echo "Conversion completed successfully!"
    exit 0
fi

# Pythonが失敗した場合、Juliaバージョンを試す（--cleanオプション付き）
echo "Python version failed, trying Julia version..."
if julia scripts/bibtex_converter.jl "$BIBTEX_FILE" --output-dir "$OUTPUT_DIR" --clean "${@:3}"; then
    echo "Conversion completed successfully with Julia!"
    exit 0
fi

echo "Both Python and Julia converters failed. Please check your installation."
exit 1
