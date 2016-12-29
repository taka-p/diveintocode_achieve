FROM ruby:2.3.0
ENV LANG C.UTF-8
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    mysql-client --no-install-recommends \
#    postgresql-client \
    vim \
    sudo \
    wget \
    curl \
    git-core \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/lib/mysql && touch /var/lib/mysql/mysql.sock
ADD ./containers/mysql/my.cnf /etc/

RUN gem install bundler

ENV GUEST_DIR /var/www
ENV APP_NAME achieve

WORKDIR $GUEST_DIR
# Docker側に$APP_NAMEディレクトリをを作成
RUN mkdir $APP_NAME

WORKDIR $APP_NAME
# Host側からDockerにプロジェクトをコピー
ADD . .
# Docker側でbundle install
RUN bundle config git.allow_insecure true
RUN bundle install

# 3000番を公開
EXPOSE 3000
