source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'bootstrap-sass', '2.0.4'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'bootswatch-rails'
gem 'activeadmin'
#gem 'sunspot_rails'
#gem 'progress_bar'
gem 'newrelic_rpm'
gem 'exception_notification' , git: 'git://github.com/alanjds/exception_notification.git' , :require => 'exception_notifier'


#Refinery
git 'git://github.com/resolve/refinerycms.git', :branch => '2-0-stable' do
  gem 'refinerycms-core' #You can leave this out if you like. It's a dependency of the other engines.
  gem 'refinerycms-dashboard'
  gem 'refinerycms-images'
  gem 'refinerycms-pages'
  gem 'refinerycms-resources'
end
  
gem 'refinerycms-inquiries', '~> 2.0.0'
  

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development, :test do
  group :development, :test do
  gem 'sqlite3'
end
  #gem 'sunspot_solr'
end
gem 'devise', '1.4.7'
gem 'acts_as_commentable_with_threading'
gem 'acts-as-taggable-on', '~> 2.3.1'

group :production do
  gem 'pg', '0.12.2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'debugger'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 2.0.0'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
