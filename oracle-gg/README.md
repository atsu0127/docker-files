# oracle-gg

oracle golden gate free を docker image で試してみる

## 注意

- Apple Silicon の Mac でやろうとしてのですが colima 使ってもできなくて断念しました
- この手順は OCI で払い出した compute(OEL8)上で実行します
  - Network は 8080 の ingress を許可しておいてください
- OEL8 系を使っているせいか ansible-core が 2.17 系だと失敗しました(`future feature annotations is not defined`)。2.16 系を入れてください。

## 使い方

### 1. 事前準備

- `ansible-playbook`コマンドを実行できるようにしておいてください(OEL8 でやる場合は ansible-core 2.16 系)

### 2. 環境作成

```bash
# oracle-ggディレクトリにて
## ipアドレス記載(既存のものは消してOK)
vim invenroties/hosts.yaml

ansible-playbook -i inventories/hosts.yaml install.yaml
```

### 3. OGG コンテナ作成

```bash
# OCIのcompute上で
## 一応再ログイン
exec "$SHELL"

## 実行
docker compose up -d
```

あとは`http://<ip>:8080`にアクセスすれば OGG の GUI が出てくるのでそこで操作すれば OK([参考](https://www.youtube.com/watch?v=45aFXF5mNEA))
