# @Debian (Docker for Mac)
FROM ruby:2.3.0
ENV LANG C.UTF-8
RUN apt-get update && apt-get install -y apt-utils \
# mariadb and mysqlバージョン
    libmysqld-dev \
# PosgreSQLバージョン
#    postgresql-client \
#    libpq-dev \
    # nokogiri用
    libxml2-dev libxslt1-dev \
    # rmagic用
    imagemagick libmagickwand-dev \
    # js runtime用
    nodejs \
    # 開発関連ツール群
    build-essential \
    vim \
    sudo \
    wget \
    curl \
    git-core --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# mysql.sockとmy.cnfを設置
RUN mkdir /var/lib/mysql && touch /tmp/mysql.sock
ADD ./containers/mariadb/my.cnf /etc/

# 各種gem
RUN gem install bundler

ENV GUEST_DIR /var/www
ENV APP_NAME achieve

WORKDIR $GUEST_DIR
# Docker側に$APP_NAMEディレクトリをを作成
RUN mkdir $APP_NAME

WORKDIR $APP_NAME
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

# Docker側でbundle install
RUN bundle config git.allow_insecure true
RUN bundle install

# Host側からDockerにプロジェクトをコピー
# .dockerignoreで.bundle, vendorは弾いている
ADD . .

# 3000番を公開
EXPOSE 3000
