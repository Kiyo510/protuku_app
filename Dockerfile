FROM ruby:2.7.1

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
  apt-get install -y build-essential \
  nodejs

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
  && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qq \
  && apt-get install -y google-chrome-stable libnss3 libgconf-2-4

# chromedriverの最新をインストール
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
  && curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
  && unzip /tmp/chromedriver_linux64.zip \
  && mv chromedriver /usr/local/bin/

# Imagemagicをインストール
RUN apt-get update && apt-get install -y imagemagick libmagick++-dev

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
WORKDIR /webapp

# ホストのGemfileとGemfile.lockをコンテナにコピー
COPY Gemfile /webapp/Gemfile
COPY Gemfile.lock /webapp/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
COPY . /webapp

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
