# docker-files

Docker 用のファイルを置いておきます

## 概要

### postgresql

種々の postgresql の検証に使います。

現状以下の検証手順があります。

- pitr
- reindex
- cluster

### postgresql-source-debug

基本 postgresql と同じですが、debug オプションをつけてビルドしてます。

### SQL\*Plus

以下のファイルが含まれています。M1 Mac に sqlplus 入れるのがだるくて作りました。

- Dockerfile…sqlplus できるコンテナイメージ作ります、`admin`というフォルダに`tnsnames.ora`とか`sqlnet.ora`とか格納してください。

### Prometheus

以下のファイルが含まれてます。prometheus service を起動するだけです。

- docker-compose.yaml…`node_exporter`と`prometheus-server`の設定が入ってます
- config/prometheus.yml…prometheus server の設定です
- config/rules.yml…Prometheus の Alert Rule 設定です
- config/alertmanager.yml…Alertmanager の設定です、Slack での通知設定です
- node-exporter-volume…node-exporter コンテナの`/volume_dir`にマウントされます。ファイルを置いたりして、メトリックの変動を確認できます
- prometheus-data…prometheus のデータが入ります

### Linux-structure

[Linux のしくみ](https://gihyo.jp/book/2022/978-4-297-13148-7)を実施するための環境です。

### oracle-ords

- Oracle の ORDS および JSON 関係を確認するためのもの

### oracle-gg

- Oracle の GoldenGate Free を検証するためのもの
- 追ってFreeじゃない方使って PostgreSQL - Oracle とかもやってみたい
