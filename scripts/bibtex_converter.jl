#!/usr/bin/env julia
"""
BibTeX to Jekyll Publications Converter (Julia版)

このスクリプトはBibTeXファイルを解析して、Jekyll用の論文Markdownファイルに変換します。

使用方法:
    julia bibtex_converter.jl input.bib [--output-dir _publications]

依存関係:
    using Pkg; Pkg.add("Bibliography")
    using Pkg; Pkg.add("ArgParse")
"""

using Bibliography
using ArgParse
using Dates

function clean_text(text::AbstractString)
    """BibTeXの特殊文字を除去し、テキストをクリーンにする"""
    if isempty(text)
        return ""
    end
    
    # 波括弧を除去
    text = replace(text, r"[{}]" => "")
    # 複数のスペースを単一のスペースに
    text = replace(text, r"\s+" => " ")
    # 前後の空白を除去
    text = strip(text)
    
    return text
end

function extract_authors(authors_raw::AbstractString)
    """著者名をフォーマットする"""
    if isempty(authors_raw)
        return ""
    end
    
    # "and" で分割
    authors = [strip(author) for author in split(authors_raw, " and ")]
    
    # 姓、名の順序を調整
    formatted_authors = String[]
    for author in authors
        if occursin(",", author)
            # "Last, First" 形式
            parts = split(author, ",", limit=2)
            if length(parts) == 2
                last, first = strip(parts[1]), strip(parts[2])
                push!(formatted_authors, "$last, $first")
            else
                push!(formatted_authors, strip(author))
            end
        else
            push!(formatted_authors, strip(author))
        end
    end
    
    return join(formatted_authors, "; ")
end

function get_entry_type(entry_type::AbstractString)
    """BibTeX entry typeをJekyll typeに変換"""
    type_mapping = Dict(
        "article" => "journal",
        "inproceedings" => "conference",  # 国内学会として扱う
        "incollection" => "conference",   # 国内学会として扱う
        "book" => "book",
        "phdthesis" => "thesis",
        "mastersthesis" => "thesis",
        "techreport" => "report",
        "misc" => "misc"
    )
    return get(type_mapping, lowercase(entry_type), "misc")
end

function generate_filename(entry::Entry)
    """ファイル名を生成"""
    # 著者の姓を取得
    authors = get(entry, "author", "")
    first_author = split(authors, " and ")[1]
    if occursin(",", first_author)
        lastname = strip(split(first_author, ",")[1])
    else
        # "First Last" 形式の場合、最後の単語を姓とする
        words = split(first_author)
        lastname = isempty(words) ? "unknown" : words[end]
    end
    
    # 年を取得
    year = get(entry, "year", "unknown")
    
    # タイトルから短縮版を作成
    title = get(entry, "title", "")
    title_words = [m.match for m in eachmatch(r"\w+", lowercase(title))]
    title_short = isempty(title_words) ? "untitled" : join(title_words[1:min(3, length(title_words))])
    
    filename = "$(lowercase(lastname))$(year)$(title_short).md"
    # ファイル名に使えない文字を除去
    filename = replace(filename, r"[^\w\-_.]" => "")
    
    return filename
end

function convert_entry_to_markdown(entry::Entry)
    """BibTeX entryをMarkdownに変換"""
    entry_type = get_entry_type(string(entry.type))
    title = clean_text(get(entry, "title", ""))
    authors = extract_authors(get(entry, "author", ""))
    year = get(entry, "year", "")
    
    # Front matter
    front_matter = [
        "---",
        "layout: default",
        "title: \"$title\"",
        "year: $year",
        "type: $entry_type",
        "authors: \"$authors\""
    ]
    
    # 出版情報
    if haskey(entry, "journal")
        venue = clean_text(entry["journal"])
        push!(front_matter, "venue: \"$venue\"")
    elseif haskey(entry, "booktitle")
        venue = clean_text(entry["booktitle"])
        push!(front_matter, "venue: \"$venue\"")
    elseif haskey(entry, "publisher") && entry_type == "book"
        venue = clean_text(entry["publisher"])
        push!(front_matter, "venue: \"$venue\"")
    end
    
    # 巻・号
    if haskey(entry, "volume")
        volume = entry["volume"]
        if haskey(entry, "number")
            volume *= "($(entry["number"]))"
        end
        push!(front_matter, "volume: \"$volume\"")
    end
    
    # ページ
    if haskey(entry, "pages")
        pages = replace(entry["pages"], "--" => "-")
        push!(front_matter, "pages: \"$pages\"")
    end
    
    # 出版社
    if haskey(entry, "publisher") && entry_type != "book"
        publisher = clean_text(entry["publisher"])
        push!(front_matter, "publisher: \"$publisher\"")
    end
    
    # DOI
    if haskey(entry, "doi")
        doi = entry["doi"]
        push!(front_matter, "doi: \"$doi\"")
    end
    
    # ISBN
    if haskey(entry, "isbn")
        isbn = entry["isbn"]
        push!(front_matter, "isbn: \"$isbn\"")
    end
    
    # Abstract
    if haskey(entry, "abstract")
        abstract = clean_text(entry["abstract"])
        push!(front_matter, "abstract: \"$abstract\"")
    end
    
    push!(front_matter, "---")
    
    # Body content
    body = [
        "",
        "## {{ page.title }}",
        "",
        "**著者:** {{ page.authors }}",
        "**出版年:** {{ page.year }}"
    ]
    
    if entry_type == "journal"
        append!(body, [
            "**掲載誌:** {{ page.venue }}",
            "{% if page.volume %}**巻号:** {{ page.volume }}{% endif %}",
            "{% if page.pages %}**ページ:** {{ page.pages }}{% endif %}",
            "{% if page.publisher %}**出版社:** {{ page.publisher }}{% endif %}"
        ])
    elseif entry_type == "conference"
        append!(body, [
            "**掲載誌:** {{ page.venue }}",
            "{% if page.pages %}**ページ:** {{ page.pages }}{% endif %}",
            "{% if page.publisher %}**出版社:** {{ page.publisher }}{% endif %}"
        ])
    elseif entry_type == "book"
        append!(body, [
            "**出版社:** {{ page.venue }}",
            "{% if page.isbn %}**ISBN:** {{ page.isbn }}{% endif %}"
        ])
    end
    
    append!(body, [
        "{% if page.doi %}**DOI:** [{{ page.doi }}](https://doi.org/{{ page.doi }}){% endif %}",
        "",
        "### 概要",
        "{{ page.abstract }}",
        "",
        "### APA 7th Style Citation"
    ])
    
    # APA citation format
    if entry_type == "journal"
        apa_format = "{{ page.authors }} ({{ page.year }}). {{ page.title }}. *{{ page.venue }}*{% if page.volume %}, *{{ page.volume }}*{% endif %}{% if page.pages %}, {{ page.pages }}{% endif %}. {% if page.doi %}https://doi.org/{{ page.doi }}{% endif %}"
    elseif entry_type == "conference" || entry_type == "international_conference"
        apa_format = "{{ page.authors }} ({{ page.year }}). {{ page.title }}. In *{{ page.venue }}*{% if page.pages %} (pp. {{ page.pages }}){% endif %}. {% if page.publisher %}{{ page.publisher }}.{% endif %} {% if page.doi %}https://doi.org/{{ page.doi }}{% endif %}"
    elseif entry_type == "book"
        apa_format = "{{ page.authors }} ({{ page.year }}). *{{ page.title }}*. {{ page.venue }}. {% if page.doi %}https://doi.org/{{ page.doi }}{% endif %}"
    else
        apa_format = "{{ page.authors }} ({{ page.year }}). {{ page.title }}. {{ page.venue }}. {% if page.doi %}https://doi.org/{{ page.doi }}{% endif %}"
    end
    
    push!(body, apa_format)
    
    return join(vcat(front_matter, body), "\n")
end

function parse_commandline()
    s = ArgParseSettings()
    
    @add_arg_table! s begin
        "bibtex_file"
            help = "Input BibTeX file path"
            required = true
        "--output-dir", "-o"
            help = "Output directory for generated Markdown files"
            default = "_publications"
        "--force", "-f"
            help = "Overwrite existing files"
            action = :store_true
        "--clean", "-c"
            help = "Clean existing .md files in output directory before conversion"
            action = :store_true
    end
    
    return parse_args(s)
end

function main()
    args = parse_commandline()
    
    # BibTeXファイルの存在確認
    if !isfile(args["bibtex_file"])
        println("Error: BibTeX file '$(args["bibtex_file"])' not found.")
        return 1
    end
    
    # 出力ディレクトリの作成
    output_dir = args["output-dir"]
    if !isdir(output_dir)
        mkpath(output_dir)
    end
    
    # 既存のMarkdownファイルをクリーンアップ
    if args["clean"]
        println("Cleaning up existing Markdown files in $output_dir...")
        md_files = filter(f -> endswith(f, ".md"), readdir(output_dir))
        if !isempty(md_files)
            for md_file in md_files
                rm(joinpath(output_dir, md_file))
            end
            println("Deleted $(length(md_files)) existing .md files")
        else
            println("No existing .md files found")
        end
    end
    
    # BibTeXファイルの解析
    try
        bib = import_bibtex(args["bibtex_file"])
        println("Found $(length(bib)) entries in BibTeX file")
        
        # 各エントリを変換
        for entry in bib
            try
                filename = generate_filename(entry)
                output_path = joinpath(output_dir, filename)
                
                # ファイルが既に存在する場合の処理
                if isfile(output_path) && !args["force"]
                    println("Skipping $filename (already exists, use --force to overwrite)")
                    continue
                end
                
                markdown_content = convert_entry_to_markdown(entry)
                
                open(output_path, "w") do f
                    write(f, markdown_content)
                end
                
                println("Generated: $filename")
                
            catch e
                entry_id = get(entry, "id", "unknown")
                println("Error processing entry $entry_id: $e")
            end
        end
        
        println("\nConversion completed. Files saved to $output_dir/")
        return 0
        
    catch e
        println("Error reading BibTeX file: $e")
        return 1
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    exit(main())
end
