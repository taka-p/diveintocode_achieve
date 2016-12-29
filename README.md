# Rails学習用アプリケーション

## Dockerコンテナの立ち上げ方


1. プロジェクトclone
```
$ git clone git@github.com:taka-p/diveintocode_achieve.git achieve
```
2. Docker for Macインストール
3. ファイル同期用のプラグイン導入(Homebrewを利用)
```
$ gem install docker-sync
$ brew install fswatch
$ brew tap homebrew/dupes
$ brew install rsync
```
4. コンテナ群のビルド、マイグレーション、起動
```
$ docker-compose build
$ docker-compose run rails bundle exec rake db:create db:migrate
$ docker-compose up -d
$ docker-sync start
```

