source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'bcrypt', '~> 3.1.7'
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'mini_racer', platforms: :ruby
gem 'omniauth'
gem 'omniauth-slack'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'puma_worker_killer'
gem 'rails', '~> 5.2.2'
gem 'rack-timeout'
gem 'sass-rails', '~> 5.0'
gem 'slack-ruby-client'
gem 'uglifier', '>= 1.3.0'

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', require: false
  gem 'webmock'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'faker'
  gem 'rspec'
  gem 'rspec-collection_matchers'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'foreman'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :staging, :production do
  gem 'heroku-deflater'
  gem 'rails_12factor'
  gem 'scout_apm'
  gem 'tunemygc'
end
