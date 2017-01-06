# docker@development用の設定

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 2)
working_directory "."
timeout 30
pid "/tmp/development_unicorn.pid"
stderr_path "./log/development_unicorn_error.log"
stdout_path "./log/development_unicorn.log"
preload_app true
check_client_connection false
run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
