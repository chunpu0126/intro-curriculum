FROM --platform=linux/x86_64 node:16.14.2-slim

RUN apt-get update
RUN apt-get install -y locales git procps vim tmux
RUN locale-gen ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR /app

# 👇 パッケージ定義をコンテナにコピー
COPY package*.json ./

# 👇 依存モジュールをインストール
RUN npm install

# 👇 アプリのソースコードをコピー（.dockerignore で node_modules 除外するのがベター）
COPY . .

CMD ["node", "bin/www"]

