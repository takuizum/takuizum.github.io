#!/usr/bin/env python3
"""
BibTeX to Jekyll Publications Converter

このスクリプトはBibTeXファイルを解析して、Jekyll用の論文Markdownファイルに変換します。

使用方法:
    python bibtex_converter.py input.bib [--output-dir _publications]

依存関係:
    pip install bibtexparser
"""

import argparse
import os
import re
from pathlib import Path
import bibtexparser
from bibtexparser.bparser import BibTexParser
from bibtexparser.customization import convert_to_unicode


def clean_text(text):
    """BibTeXの特殊文字を除去し、テキストをクリーンにする"""
    if not text:
        return ""
    
    # 波括弧を除去
    text = re.sub(r'[{}]', '', text)
    # 複数のスペースを単一のスペースに
    text = re.sub(r'\s+', ' ', text)
    # 前後の空白を除去
    text = text.strip()
    
    return text


def extract_authors(authors_raw):
    """著者名をフォーマットする"""
    if not authors_raw:
        return ""
    
    # "and" で分割
    authors = [author.strip() for author in authors_raw.split(' and ')]
    
    # 姓、名の順序を調整
    formatted_authors = []
    for author in authors:
        if ',' in author:
            # "Last, First" 形式
            parts = author.split(',', 1)
            if len(parts) == 2:
                last, first = parts[0].strip(), parts[1].strip()
                formatted_authors.append(f"{last}, {first}")
            else:
                formatted_authors.append(author.strip())
        else:
            formatted_authors.append(author.strip())
    
    return '; '.join(formatted_authors)


def get_entry_type(entry_type):
    """BibTeX entry typeをJekyll typeに変換"""
    type_mapping = {
        'article': 'journal',
        'inproceedings': 'conference',  # 国内学会として扱う
        'incollection': 'conference',   # 国内学会として扱う
        'book': 'book',
        'phdthesis': 'thesis',
        'mastersthesis': 'thesis',
        'techreport': 'report',
        'misc': 'misc'
    }
    return type_mapping.get(entry_type.lower(), 'misc')


def generate_filename(entry):
    """ファイル名を生成"""
    # 著者の姓を取得
    authors = entry.get('author', '')
    first_author = authors.split(' and ')[0] if authors else 'unknown'
    if ',' in first_author:
        lastname = first_author.split(',')[0].strip()
    else:
        # "First Last" 形式の場合、最後の単語を姓とする
        lastname = first_author.split()[-1] if first_author.split() else 'unknown'
    
    # 年を取得
    year = entry.get('year', 'unknown')
    
    # タイトルから短縮版を作成
    title = entry.get('title', '')
    title_words = re.findall(r'\w+', title.lower())
    title_short = ''.join(title_words[:3]) if title_words else 'untitled'
    
    filename = f"{lastname.lower()}{year}{title_short}.md"
    # ファイル名に使えない文字を除去
    filename = re.sub(r'[^\w\-_.]', '', filename)
    
    return filename


def convert_entry_to_markdown(entry):
    """BibTeX entryをMarkdownに変換"""
    entry_type = get_entry_type(entry['ENTRYTYPE'])
    title = clean_text(entry.get('title', ''))
    authors = extract_authors(entry.get('author', ''))
    year = entry.get('year', '')
    
    # Front matter
    front_matter = [
        "---",
        "layout: default",
        f'title: "{title}"',
        f"year: {year}",
        f"type: {entry_type}",
        f'authors: "{authors}"'
    ]
    
    # 出版情報
    if 'journal' in entry:
        venue = clean_text(entry['journal'])
        front_matter.append(f'venue: "{venue}"')
    elif 'booktitle' in entry:
        venue = clean_text(entry['booktitle'])
        front_matter.append(f'venue: "{venue}"')
    elif 'publisher' in entry and entry_type == 'book':
        venue = clean_text(entry['publisher'])
        front_matter.append(f'venue: "{venue}"')
    
    # 巻・号
    if 'volume' in entry:
        volume = entry['volume']
        if 'number' in entry:
            volume += f"({entry['number']})"
        front_matter.append(f'volume: "{volume}"')
    
    # ページ
    if 'pages' in entry:
        pages = entry['pages'].replace('--', '-')
        front_matter.append(f'pages: "{pages}"')
    
    # 出版社
    if 'publisher' in entry and entry_type != 'book':
        publisher = clean_text(entry['publisher'])
        front_matter.append(f'publisher: "{publisher}"')
    
    # DOI
    if 'doi' in entry:
        doi = entry['doi']
        front_matter.append(f'doi: "{doi}"')
    
    # ISBN
    if 'isbn' in entry:
        isbn = entry['isbn']
        front_matter.append(f'isbn: "{isbn}"')
    
    # Abstract
    if 'abstract' in entry:
        abstract = clean_text(entry['abstract'])
        front_matter.append(f'abstract: "{abstract}"')
    
    front_matter.append("---")
    
    # Body content
    body = [
        "",
        "## {{ page.title }}",
        "",
        "**著者:** {{ page.authors }}",
        "**出版年:** {{ page.year }}"
    ]
    
    if entry_type == 'journal':
        body.extend([
            "**掲載誌:** {{ page.venue }}",
            "{% if page.volume %}**巻号:** {{ page.volume }}{% endif %}",
            "{% if page.pages %}**ページ:** {{ page.pages }}{% endif %}",
            "{% if page.publisher %}**出版社:** {{ page.publisher }}{% endif %}"
        ])
    elif entry_type == 'conference':
        body.extend([
            "**掲載誌:** {{ page.venue }}",
            "{% if page.pages %}**ページ:** {{ page.pages }}{% endif %}",
            "{% if page.publisher %}**出版社:** {{ page.publisher }}{% endif %}"
        ])
    elif entry_type == 'book':
        body.extend([
            "**出版社:** {{ page.venue }}",
            "{% if page.isbn %}**ISBN:** {{ page.isbn }}{% endif %}"
        ])
    
    body.extend([
        "{% if page.doi %}**DOI:** [{{ page.doi }}](https://doi.org/{{ page.doi }}){% endif %}",
        "",
        "### 概要",
        "{{ page.abstract }}",
        "",
        "### APA 7th Style Citation"
    ])
    
    # APA citation format
    if entry_type == 'journal':
        apa_format = "{{ page.authors }} ({{ page.year }}). {{ page.title }}. *{{ page.venue }}*{% if page.volume %}, *{{ page.volume }}*{% endif %}{% if page.pages %}, {{ page.pages }}{% endif %}. {% if page.doi %}https://doi.org/{{ page.doi }}{% endif %}"
    elif entry_type == 'conference' or entry_type == 'international_conference':
        apa_format = "{{ page.authors }} ({{ page.year }}). {{ page.title }}. In *{{ page.venue }}*{% if page.pages %} (pp. {{ page.pages }}){% endif %}. {% if page.publisher %}{{ page.publisher }}.{% endif %} {% if page.doi %}https://doi.org/{{ page.doi }}{% endif %}"
    elif entry_type == 'book':
        apa_format = "{{ page.authors }} ({{ page.year }}). *{{ page.title }}*. {{ page.venue }}. {% if page.doi %}https://doi.org/{{ page.doi }}{% endif %}"
    else:
        apa_format = "{{ page.authors }} ({{ page.year }}). {{ page.title }}. {{ page.venue }}. {% if page.doi %}https://doi.org/{{ page.doi }}{% endif %}"
    
    body.append(apa_format)
    
    return '\n'.join(front_matter + body)


def main():
    parser = argparse.ArgumentParser(description='Convert BibTeX file to Jekyll publications')
    parser.add_argument('bibtex_file', help='Input BibTeX file path')
    parser.add_argument('--output-dir', '-o', default='_publications', 
                       help='Output directory for generated Markdown files')
    parser.add_argument('--force', '-f', action='store_true',
                       help='Overwrite existing files')
    parser.add_argument('--clean', '-c', action='store_true',
                       help='Clean existing .md files in output directory before conversion')
    
    args = parser.parse_args()
    
    # BibTeXファイルの存在確認
    if not os.path.exists(args.bibtex_file):
        print(f"Error: BibTeX file '{args.bibtex_file}' not found.")
        return 1
    
    # 出力ディレクトリの作成
    output_dir = Path(args.output_dir)
    output_dir.mkdir(exist_ok=True)
    
    # 既存のMarkdownファイルをクリーンアップ
    if args.clean:
        print(f"Cleaning up existing Markdown files in {output_dir}...")
        md_files = list(output_dir.glob("*.md"))
        if md_files:
            for md_file in md_files:
                md_file.unlink()
            print(f"Deleted {len(md_files)} existing .md files")
        else:
            print("No existing .md files found")
    
    # BibTeXファイルの解析
    parser_bibtex = BibTexParser(common_strings=True)
    parser_bibtex.customization = convert_to_unicode
    
    try:
        with open(args.bibtex_file, 'r', encoding='utf-8') as bibtex_file:
            bib_database = bibtexparser.load(bibtex_file, parser=parser_bibtex)
    except Exception as e:
        print(f"Error reading BibTeX file: {e}")
        return 1
    
    print(f"Found {len(bib_database.entries)} entries in BibTeX file")
    
    # 各エントリを変換
    for entry in bib_database.entries:
        try:
            filename = generate_filename(entry)
            output_path = output_dir / filename
            
            # ファイルが既に存在する場合の処理
            if output_path.exists() and not args.force:
                print(f"Skipping {filename} (already exists, use --force to overwrite)")
                continue
            
            markdown_content = convert_entry_to_markdown(entry)
            
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(markdown_content)
            
            print(f"Generated: {filename}")
            
        except Exception as e:
            print(f"Error processing entry {entry.get('ID', 'unknown')}: {e}")
    
    print(f"\nConversion completed. Files saved to {output_dir}/")
    return 0


if __name__ == '__main__':
    exit(main())
