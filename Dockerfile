##########################################################
#### ビルドステージ
FROM node:18.7.0-alpine3.15 as builder
WORKDIR /work

# ビルド用の依存パッケージをインストール
COPY package*.json ./
RUN npm install

# TypeScript コードをコピーしてビルド
COPY src tsconfig.json ./
RUN npm run build

##########################################################
#### 実行用イメージの作成
FROM node:18.7.0-alpine3.15 as runner
WORKDIR /work

ENV NODE_ENV production
ENV PORT 3000
EXPOSE 3000

# 本番環境用のパッケージをインストール
COPY package*.json ./
RUN npm install --omit=dev && npm cache clean --force

# builder からビルド結果だけコピー
COPY --from=builder /work/out ./out

# Node.js アプリを起動
CMD ["node", "./out/index.js"]