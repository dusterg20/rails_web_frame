source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.3'

gem 'rails',                    '~> 5.2.3'
gem 'bcrypt',                   '~> 3.1', '>= 3.1.13'
gem 'faker',                    '~> 1.9', '>= 1.9.6'
gem 'carrierwave',              '~> 1.3', '>= 1.3.1'
gem 'mini_magick',              '~> 4.9', '>= 4.9.5'
gem 'will_paginate',            '~> 3.1', '>= 3.1.7'
gem 'bootstrap-will_paginate',  '~> 1.0'
gem 'puma',                     '~> 4.0', '>= 4.0.1'
gem 'sass-rails',               '~> 5.0', '>= 5.0.7'
gem 'uglifier',                 '~> 4.1', '>= 4.1.20'
gem 'coffee-rails',             '~> 5.0'
gem 'jquery-rails',             '~> 4.3', '>= 4.3.5'
gem 'turbolinks',               '~> 5.2'
gem 'jbuilder',                 '~> 2.9', '>= 2.9.1'
gem 'pg',                       '~> 1.1', '>= 1.1.4'
gem 'bootstrap',                '~> 4.3.1'
gem 'bootsnap',                 '>= 1.1.0', require: false
gem 'popper_js',                '~> 1.14', '>= 1.14.5'
gem 'nokogiri',                 '~> 1.10', '>= 1.10.4'

group :development, :test do
gem 'pry-rails', '~> 0.3.4'
gem 'pry', '~> 0.12.2'
end

group :development do
  gem 'bindex', '~> 0.8.1'
  gem 'web-console', '~> 3.5', '>= 3.5.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest',                 '5.11.3'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.14.1'
  gem 'guard-minitest',           '2.4.6'
end

group :production do
  gem 'fog', '1.42'
end
