# http://jetglass.hatenablog.jp/entry/2015/06/26/205256

# rails_root = File.expand_path('../../', __FILE__)
# rails_env = ENV['RAILS_ENV'] || "development"
#
# worker_processes 2
# working_directory rails_root
#
# listen "#{rails_root}/tmp/#{rails_env}_unicorn.sock"
# # unicorn接続テスト用
# # listen 8080
# pid "#{rails_root}/tmp/#{rails_env}_unicorn.pid"
#
# stderr_path "#{rails_root}/log/#{rails_env}_unicorn_error.log"
# stdout_path "#{rails_root}/log/#{rails_env}_unicorn.log"
#
# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) and
#       ActiveRecord::Base.connection.disconnect!
#
#   old_pid = "#{server.config[:pid]}.oldbin"
#   if old_pid != server.pid
#     begin
#       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
#       Process.kill(sig, File.read(old_pid).to_i)
#     rescue Errno::ENOENT, Errno::ESRCH
#     end
#   end
# end
#
# after_fork do |server, worker|
#   defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
# end


# set lets
$worker  = 2
$timeout = 30
$app_dir = "/var/www/achieve/current" #自分のアプリケーション名、currentがつくことに注意。
$listen  = File.expand_path 'tmp/sockets/.unicorn.sock', $app_dir
$pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
$std_log = File.expand_path 'log/unicorn.log', $app_dir
# set config
worker_processes  $worker
working_directory $app_dir
stderr_path $std_log
stdout_path $std_log
timeout $timeout
listen  $listen
pid $pid
# loading booster
preload_app true
# before starting processes
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
# after finishing processes
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
