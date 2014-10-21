source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'jquery.fileupload-rails'

gem 'fancybox2-rails', '~> 0.2.8'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jquery-turbolinks'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# User Authentication
gem 'devise'

# Image uploading gem
gem 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'

# Authorization
gem "cancan"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'countries'
gem 'country_select'

# send list of campaigns/beacons based on location
gem 'geocoder'
gem 'geokit-rails'
gem "highcharts-rails", "~> 3.0.0"
# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'sorted'
# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'jc-validates_timeliness' #date validation
# using haml instead of erb
gem 'haml'
gem "haml-rails"

#send push notification
gem 'push-core'
#send push notification on ios
gem 'push-apns'
#send push notification on android
gem 'push-gcm'

# Delayed::Job (or DJ)
gem 'daemons'
gem 'delayed_job_active_record'

#writing and deploying cron jobs
gem 'whenever', :require => false

#testing gems
group :development, :test do
  gem 'rspec-rails'
  gem 'spork-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'poltergeist'
  gem 'launchy'
  gem 'selenium-webdriver'
end

