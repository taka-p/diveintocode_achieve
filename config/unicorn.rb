# http://jetglass.hatenablog.jp/entry/2015/06/26/205256

rails_root = File.expand_path('../../', __FILE__)
rails_env = ENV['RAILS_ENV'] || "development"

worker_processes 2
working_directory rails_root

listen "#{rails_root}/tmp/#{rails_env}_unicorn.sock"
# unicorn接続テスト用
# listen 8080
pid "#{rails_root}/tmp/#{rails_env}_unicorn.pid"

stderr_path "#{rails_root}/log/#{rails_env}_unicorn_error.log"
stdout_path "#{rails_root}/log/#{rails_env}_unicorn.log"


# worker_processes Integer(ENV["WEB_CONCURRENCY"] || 2)
# working_directory "/myapp" # available in 0.94.0+
# pid "/tmp/unicorn.pid"
#
# stderr_path "/myapp/log/unicorn.stderr.log"
# stdout_path "/myapp/log/unicorn.stdout.log"
#
# preload_app true
#
# check_client_connection false
#
# run_once = true
#
# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) and
#       ActiveRecord::Base.connection.disconnect!
#
#   if run_once
#     run_once = false # prevent from firing again
#   end
# end
#
# after_fork do |server, worker|
#   defined?(ActiveRecord::Base) and
#       ActiveRecord::Base.establish_connection
# end