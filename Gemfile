source 'https://rubygems.org'


gem 'rails', '3.2.6'
gem "thin", '1.4.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "bootstrap-sass", "~> 2.1.0.0"
end

gem 'jquery-rails'

gem "mongoid", "~> 3.0.9"
gem 'activeadmin-mongoid', git: 'https://github.com/elia/activeadmin-mongoid.git'
gem "devise", ">= 2.1.0"
gem "simple_form", "~> 2.0.2"
gem "rails3-jquery-autocomplete", "~> 1.0.9"


gem "kaminari", "~> 0.13.0"
gem "twilio-ruby", "~> 3.8.0"
gem "evently", "~> 0.0.1"
#gem "evently", :path => '/Users/davidshapiro/Documents/Gems/evently' #git: 'https://github.com/dsshap/evently.git'

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

group :development do
  gem "quiet_assets", "~> 1.0.1"
end

group :development, :test do
  gem "rspec-rails", ">= 2.10.1"
  gem "factory_girl_rails", ">= 3.5.0"
end

group :test do
  gem "database_cleaner", ">= 0.7.2"
  gem "mongoid-rspec", "~> 1.5.4"
  gem "email_spec", ">= 1.2.1"
end