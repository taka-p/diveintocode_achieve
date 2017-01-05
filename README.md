# Rails学習用アプリケーション

## 動作環境

- Ruby: 2.3.0  
- Rails: 4.2.0  
- DB: MariaDB（PostgreSQLでもOK）  
- AppServer: unicorn  
- WebServer: nginx  

## Dockerコンテナの立ち上げ方

#### 1. プロジェクトclone
```
$ git clone git@github.com:taka-p/diveintocode_achieve.git achieve
```
#### 2. Docker for Macインストール
[Docker for Mac](https://docs.docker.com/docker-for-mac/)
#### 3. ファイル同期用のプラグイン導入(Homebrewを利用)
```
$ gem install docker-sync
$ brew install fswatch
$ brew tap homebrew/dupes
$ brew install rsync
```
#### 4. コンテナ群のビルド、マイグレーション、起動
```
$ docker-compose build
$ docker-compose run rails bundle exec rake db:create db:migrate
$ docker-compose up -d
$ docker-sync start
```
## 本番環境へのデプロイ

```
$ bundle exec cap production deploy --trace
```

## 残タスク

* 各種Dockerコンテナのデータ永続化（logやdbなど）
* Ansibleでの構成管理（開発/本番環境共に）
* 本番環境もDockerで動かす

```（）
```
