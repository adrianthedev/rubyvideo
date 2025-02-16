source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.1"

# Use main development branch of Rails
gem "rails", "~> 7.2.0.beta2"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 2.0"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma"

# use jbuilder for the api
gem "jbuilder"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
# gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
# gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
# gem "cssbundling-rails"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  gem "byebug", "~> 11.1"
  gem "dotenv-rails"
end

group :development do
  gem "annotate"
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem "ruby-lsp-rails", require: false
  gem "standardrb", "~> 1.0"
  gem "erb_lint", "~> 0.4.0"
  gem "authentication-zero", "~> 2.16"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  gem "vcr", "~> 6.1"
  gem "webmock"
end

gem "pagy", "~> 6.0"
gem "dockerfile-rails", ">= 1.2", group: :development

gem "activerecord-enhancedsqlite3-adapter"
gem "litestream", "~> 0.10.1"
gem "solid_cache"
gem "solid_queue"
gem "mission_control-jobs"

gem "inline_svg", "~> 1.9"
gem "net-http", "~> 0.3.2"
gem "meilisearch-rails"
gem "ahoy_matey", "~> 4.2"
gem "vite_rails"
gem "meta-tags", "~> 2.18"

gem "groupdate", "~> 6.2"

gem "appsignal", "~> 3.4"

gem "chartkick", "~> 5.0"

gem "rails_autolink", "~> 1.1"

gem "sitemap_generator", "~> 6.3"

gem "view_component", "~> 3.7"

gem "dry-initializer-rails"

gem "dry-types", "~> 1.7"

gem "google-protobuf", require: false

gem "active_job-performs", "~> 0.3.1"
