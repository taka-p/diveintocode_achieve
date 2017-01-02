# サーバーのIP、ログインユーザー名、サーバーのロール
server '150.95.134.240',
       user: 'rails',
       roles: %w{app db web}

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options,
    keys: '~/.ssh/id_rsa',
    port: '10022'
