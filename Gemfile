source "https://rubygems.org"

# Target Ruby version for local development and CI
ruby ">= 3.2", "< 3.5"

# Use explicit Jekyll (preferred for modern sites and plugin flexibility)
gem "bundler", ">= 2.3"
gem "jekyll", "~> 4.2"

# Common, recommended Jekyll plugins for SEO, feeds, sitemaps, redirects
gem "jekyll-seo-tag"
gem "jekyll-sitemap"
gem "jekyll-feed"
gem "jekyll-redirect-from"
gem "jekyll-paginate-v2"
gem "jekyll-include-cache"

# Support for Ruby 3+ local server
gem "webrick", "~> 1.8"

# Optional: fast Sass compilation (only if site uses Sass)
gem "sassc", "~> 2.4"

# Development tools
group :development do
  gem "jekyll-watch", "~> 2.2"
  gem "rubocop", "~> 1.43"
end

# Platform-specific data
gem "tzinfo-data", "~> 1.2024", platforms: %i[mingw mswin x64_mingw jruby]
