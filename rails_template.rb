# frozen_string_literal: true

# def source_paths
#   [File.expand_path('./templates', __dir__)]
# end

gem_group :development, :test do
  gem 'rspec-rails', '~> 3.7'

  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'guard-yard', require: false

  # Rubocop
  gem 'rubocop', '~> 0.55', require: false
  gem 'rubocop-rspec', require: false

  # Coverage
  gem 'simplecov', require: false

  # Pry is a better console than IRB
  # install_if -> { !defined?(::Vim) } do
  #   gem 'pry-byebug'
  #   gem 'pry-rails'
  # end

  gem 'colorize', require: false
end

gem_group :development do
  gem 'better_errors'
  gem 'binding_of_caller'

  # Thin is for the YARD server
  # gem 'thin', require: false
  gem 'yard', require: false
end

gem_group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.8'

  gem 'rails-controller-testing'

  gem 'faker'
end

after_bundle do
  generate 'rspec:install'

  run 'bundle exec guard init'

  in_root do
    %w[Gemfile Gemfile.lock Guardfile].each do |file|
      run "mv #{file} config/"
      run "ln -s config/#{file}"
    end
  end

  # git :init
  # git add: '.'
  # git commit: %(-m "Initial commit")
end
