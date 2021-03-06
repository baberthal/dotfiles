# frozen_string_literal: true

def source_paths
  [__dir__]
end

after_bundle do
  git :init
  git add: '.'
  git commit: %( -m 'Initial commit' )
end

gem 'pg'
gem 'postgres_ext'
gem 'pg_search'
gem 'puma'

gem_group :development, :test do
  gem 'colorize'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'pry-theme'
  gem 'factory_girl_rails'
  gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'guard-bundler', require: false
  gem 'guard-rubocop', require: false
  gem 'ruby_gntp'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'phantomjs'
  gem 'poltergeist'
  gem 'simplecov', require: false
  gem 'rubocop', require: false
  gem 'faker'
end

run 'bundle install'
generate 'rspec:install'
directory 'rails_files', './', recursive: true
run 'bundle exec guard init'
# run "rvm --ruby-version use 2.2.3@#{@app_name} --create"

#  vim: set ts=8 sw=2 tw=0 et :
