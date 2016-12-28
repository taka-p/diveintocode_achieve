# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'achieve'
set :repo_url, 'git@github.com:taka-p/diveintocode_achieve.git'

# デプロイ先ディレクトリ - Default /var/www/my_app_name
set :deploy_to, '~/achieve'

# sudoに必要 これをtrueにするとssh -tで実行される
set :pty, true

# シンボリックリンクを張るディレクトリ/ファイルの指定
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}
# set :linked_files, %w{config/secrets.yml}

# capistrano用bundleするのに必要
set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }

# rubyのバージョン
set :rbenv_ruby, '2.3.0'

# Default branch is :master
# set :branch, 'master'

# Default value for :scm is :git
# set :scm, :git

# Default value for keep_releases is 5
# set :keep_releases, 5

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# unicorn再起動タスク
namespace :deploy do
  desc 'Restart application'
  task :restart do
    #lib/capustrano/tasks/unicorn.cap内処理を実行
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  # task実行タイミングを指定
  # http://capistranorb.com/documentation/getting-started/flow/
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
