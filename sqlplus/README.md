# SQL\*Plus

これは SQL\*Plus を利用できる環境を用意しています。

`examples`には実際に使ってやってみた手順が格納されています。

## 使い方

### 下準備

`admin`というフォルダ名で

- tnsnames.ora
- sqlnet.ora
- wallet 関係(必要なら)

を格納したものを作成してください。

コピーして配置します(`ORACLE_HOME/network/admin`は以下に配置します)

### 接続方法

以下で実際に使えます

```bash
docker build -t sqlplus .
docker run -it --rm sqlplus <username>@<tns_name>
```
