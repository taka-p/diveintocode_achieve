set :production

server '150.95.134.240',      # サーバーのIP
       user: 'rails',         # ログインユーザー名
       roles: %w{app db web}, # サーバーのロール
       #デプロイするサーバーにsshログインする鍵の情報を記述
       ssh_options: {
          keys: '~/.ssh/id_rsa',
          port: '10022'
       }
