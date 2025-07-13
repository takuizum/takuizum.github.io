# BibTeX to Jekyll Publications Converter

このフォルダには、BibTeXファイルをJekyll用の論文Markdownファイルに変換するスクリプトが含まれています。

## 必要な依存関係

### Pythonバージョン
```bash
pip install bibtexparser
```

### Juliaバージョン
```julia
using Pkg
Pkg.add("Bibliography")
Pkg.add("ArgParse")
```

## 使用方法

### 基本的な使用方法

**Windows (PowerShell/Command Prompt):**
```bash
# Pythonバージョン
python scripts\bibtex_converter.py _bibliography\references.bib

# Juliaバージョン  
julia scripts\bibtex_converter.jl _bibliography\references.bib

# バッチファイル（自動でPythonまたはJuliaを選択）
scripts\convert_bibtex.bat _bibliography\references.bib
```

**Unix/Linux/macOS:**
```bash
# Pythonバージョン
python3 scripts/bibtex_converter.py _bibliography/references.bib

# Juliaバージョン
julia scripts/bibtex_converter.jl _bibliography/references.bib

# シェルスクリプト（自動でPythonまたはJuliaを選択）
./scripts/convert_bibtex.sh _bibliography/references.bib
```

### オプション

- `--output-dir`, `-o`: 出力ディレクトリを指定（デフォルト: `_publications`）
- `--force`, `-f`: 既存ファイルを上書き
- `--clean`, `-c`: 変換前に出力ディレクトリ内の既存.mdファイルを削除

**例:**
```bash
# 出力ディレクトリを指定
python scripts\bibtex_converter.py references.bib --output-dir publications

# 既存ファイルを強制上書き
python scripts\bibtex_converter.py references.bib --force

# 既存.mdファイルを削除してから変換（推奨）
python scripts\bibtex_converter.py references.bib --clean

# 複数オプションを使用
python scripts\bibtex_converter.py references.bib -o publications -c -f
```

### バッチファイル・シェルスクリプトの自動クリーンアップ

`convert_bibtex.bat` および `convert_bibtex.sh` は自動的に `--clean` オプションを使用して、毎回既存のMarkdownファイルを削除してから新しいファイルを生成します。これにより、削除されたBibTeXエントリに対応する古いMarkdownファイルが残ることを防げます。

```bash
# バッチファイル使用時は自動的にクリーンアップされます
scripts\convert_bibtex.bat _bibliography\references.bib
```

## ファイル構造

```
scripts/
├── bibtex_converter.py     # Python版コンバーター
├── bibtex_converter.jl     # Julia版コンバーター
├── convert_bibtex.bat      # Windows用バッチファイル
├── convert_bibtex.sh       # Unix/Linux/macOS用シェルスクリプト
└── README.md              # このファイル
```

## 生成されるファイル

各BibTeXエントリから、以下の形式のMarkdownファイルが生成されます：

```markdown
---
layout: default
title: "論文タイトル"
year: 2024
type: journal
authors: "著者名"
venue: "ジャーナル名"
volume: "巻(号)"
pages: "ページ番号"
doi: "DOI番号"
abstract: "概要"
---

## {{ page.title }}

**著者:** {{ page.authors }}
**出版年:** {{ page.year }}
...

### APA 7th Style Citation
著者 (年). タイトル. ジャーナル名...
```

## サポートされるBibTeXエントリタイプ

- `@article` → `journal` (ジャーナル論文)
- `@inproceedings`, `@incollection` → `conference` (国内学会発表)
- `@book` → `book` (書籍)
- `@phdthesis`, `@mastersthesis` → `thesis` (学位論文)
- `@techreport` → `report` (技術報告書)
- `@misc` → `misc` (その他)

**注意:** 現在、BibTeXの`@inproceedings`と`@incollection`は国内学会発表として扱われます。将来的に国際学会発表を追加する場合は、手動でタイプを`international_conference`に変更してください。

## トラブルシューティング

### Pythonでエラーが発生する場合
```bash
pip install --upgrade bibtexparser
```

### Juliaでエラーが発生する場合
```julia
using Pkg
Pkg.update()
Pkg.add("Bibliography")
Pkg.add("ArgParse")
```

### ファイル名の重複
同じ著者・年・タイトルのエントリがある場合、ファイル名が重複する可能性があります。
`--force` オプションを使用して上書きするか、手動でファイル名を変更してください。
