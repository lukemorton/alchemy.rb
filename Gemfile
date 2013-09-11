RUBY_ENGINE = 'ruby' unless defined? RUBY_ENGINE

source 'https://rubygems.org'

gem 'sinatra'
gem 'mustache'

# Dev dependencies
# 
gem 'rspec'
gem 'shotgun'
gem 'coveralls', require: false

if RUBY_ENGINE == 'jruby'
  gem 'trinidad'
else
  gem 'thin'
end
