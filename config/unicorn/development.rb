# http://jetglass.hatenablog.jp/entry/2015/06/26/205256

rails_root = File.expand_path('../../../', __FILE__)
rails_env = ENV['RAILS_ENV'] || "development"

worker_processes 2
working_directory rails_root

listen "#{rails_root}/tmp/#{rails_env}_unicorn.sock"
# unicorn接続テスト用
# listen 8080
pid "#{rails_root}/tmp/#{rails_env}_unicorn.pid"

stderr_path "#{rails_root}/log/#{rails_env}_unicorn_error.log"
stdout_path "#{rails_root}/log/#{rails_env}_unicorn.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
