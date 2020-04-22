source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'twitter-bootstrap-rails'

gem 'uglifier'
gem 'jquery-rails'
gem 'dotenv-rails' # работает с переменными окружения
gem 'carrierwave'
gem 'rmagick'
gem 'fog-aws'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
gem 'pundit'

gem 'puma', '~> 4.1'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

gem 'bootsnap', '>= 1.4.2', require: false

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'

  gem 'factory_bot_rails'
  gem 'sqlite3', '~> 1.4'
  gem 'listen'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'solargraph'
  gem 'rubocop'
  gem 'rspec-rails'
end
