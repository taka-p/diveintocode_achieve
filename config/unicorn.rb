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


# Capistranoでunicornを使ったアプリをデプロイしているとBundler::GemfileNotFoundという例外があがることがあるため設定
ENV['BUNDLE_GEMFILE'] = rails_root + "/Gemfile"

# Unicornは複数のワーカーで起動するのでワーカー数を定義
# サーバーのメモリなどによって変更すること。
worker_processes 2

# 指定しなくても良い。
# Unicornの起動コマンドを実行するディレクトリを指定します。
# （記載しておけば他のディレクトリでこのファイルを叩けなくなる。）
working_directory rails_root

# 接続タイムアウト時間
timeout 30

# Unicornのエラーログと通常ログの位置を指定。
stderr_path File.expand_path('../../log/unicorn_stderr.log', __FILE__)
stdout_path File.expand_path('../../log/unicorn_stdout.log', __FILE__)

# Nginxで使用する場合は以下の設定を行う。
listen File.expand_path('../../tmp/sockets/unicorn.sock', __FILE__)
# とりあえず起動して動作確認をしたい場合は以下の設定を行う。
# listen 3000

# プロセスの停止などに必要なPIDファイルの保存先を指定。
pid File.expand_path('../../tmp/pids/unicorn.pid', __FILE__)

# 基本的には`true`を指定する。Unicornの再起動時にダウンタイムなしで再起動が行われる。
preload_app true
# 効果なしとの記事を見たので、コメントアウト。
# GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

# USR2シグナルを受けると古いプロセスを止める。
# 後述するが、記述しておくとNginxと連携する時に良いことがある。
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