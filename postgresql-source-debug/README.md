# postgresql debug実行用

docker で postgresql のデバッグ実行をするためのコンテナです。

## 前提
以下は必要です。
- vscode
- docker

## 使い方
### コンテナの作り方

以下でできます

```bash
# コンテナ実行
docker build -t postgresql-source-debug:latest .
CONT=`docker run -it -d --cap-add=SYS_PTRACE --security-opt seccomp=unconfined postgresql-source-debug:latest`

# コンテナアクセス
docker exec -it ${CONT} bash

# コンテナ名確認(後で使います)
docker ps

# psqlアクセス
su - postgres
psql

# process確認
SELECT pg_backend_pid();
```

### デバッグ実行

VSCodeでデバッグ実行します([参考](https://taityo-diary.hatenablog.jp/entry/2023/02/10/074630)とはsshかリモートエクスプローラかの差です)

1. vscodeのリモートエクスプローラで↑で作成したコンテナに接続します(新しいウィンドウで接続してください)
2. `/workspace/postgresql-<version>`を開きます
3. 1で開いたウィンドウで拡張機能「C/C++」をインストールします
4. 何かしらのファイル(今回は`/workspace/postgresql-13.5/src/backend/executor/nodeResult.c`)を開いて「実行とデバッグ」を開きます
5. 「launch.json ファイルを作成します」で以下の`launch.json`を作成します
6. デバッグを実行します。
7. ブレークポイントを`/workspace/postgresql-13.5/src/backend/executor/nodeResult.c`の70行目(`ResultState`を定義している部分)において、psqlでselectなどを実行すればデバッグ実行できます

### コンテナ削除
消したかったら以下

```bash
docker stop $CONT && docker rm $CONT
```