# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"
require 'capistrano/rbenv'
set :rbenv_type, :system # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.3.0' #rubyのバージョンを指定
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

# デフォルトをproductionに設定
Rake::Task[:production].invoke
invoke :production
