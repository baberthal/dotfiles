after_bundle do
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end

gem 'pg'
gem 'postgres_ext'
gem 'pg_search'
gem 'puma'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'
  gem 'pry-rails'
  gem 'pry-theme'
  gem 'factory_girl_rails'
  gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i
  gem 'launchy'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'guard-bundler', require: false
  gem 'guard-teaspoon'
  gem 'guard-coffeescript'
  gem 'ruby_gntp'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'phantomjs'
  gem 'teaspoon-jasmine'
  gem 'poltergeist'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'simplecov', require: false
end

run 'bundle install'
generate 'rspec:install'
run 'guard init'
generate 'teaspoon:install --coffee'

#  vim: set ts=8 sw=2 tw=0 et :
