source "https://rubygems.org"

# Jekyll Core
gem "jekyll", "~> 3.10.0"

# Jekyll Cayman Theme (修正済み)
gem "jekyll-theme-cayman"

# GitHub Pages compatibility - GitHubが使用するJekyllバージョンに合わせる
gem "github-pages", group: :jekyll_plugins

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
platforms :mingw, :x64_mingw, :mswin do
  gem 'wdm', '>= 0.1.0'
end

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
