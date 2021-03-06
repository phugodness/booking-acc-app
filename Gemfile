source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'activemerchant'

# Use for paginate
gem 'kaminari'
# gem for SMS verification
gem 'twilio-ruby', '~> 4.1.0'
# gem for admin management
gem 'activeadmin'
# gem for skin of activeadmin
gem 'active_skin'

# Use for Authorization
gem 'cancancan'
# A suite use for omniauth from third party
gem 'therubyracer'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'

# Use for rich text
gem 'ckeditor'
# Use for upload images
gem 'paperclip'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-easing-rails'
gem 'momentjs-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use for Advanced Search
gem 'ransack'
# User for authentication
gem 'devise'

# Use for Google map API
gem 'geocoder'
gem 'gmaps4rails'
# bootstrap
gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootstrap-daterangepicker-rails'
gem 'bootstrap-datepicker-rails'
# Font awesome
gem 'font-awesome-rails'

# Pass date from server to Js
gem 'gon'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # Use for detect any N+1 query and fix it
  gem 'bullet'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
