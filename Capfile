require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

set :rbenv_type, :system
set :rbenv_ruby, '2.3.0'

load 'deploy/assets'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

# デフォルトをproductionに設定 cap deploy
# エラーが出るためコメントアウト
# Rake::Task[:production].invoke
# invoke :production
