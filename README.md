# docker-files
Docker用のファイルを置いておきます

## 概要
### postgresql
種々のpostgresqlの検証に使います。

現状以下の検証手順があります。
- pitr
- reindex
- cluster

### postgresql-source-debug
基本postgresqlと同じですが、debugオプションをつけてビルドしてます。

### SQL\*Plus
以下のファイルが含まれています。M1 Macにsqlplus入れるのがだるくて作りました。
- Dockerfile…sqlplusできるコンテナイメージ作ります、`admin`というフォルダに`tnsnames.ora`とか`sqlnet.ora`とか格納してください。

### Prometheus
以下のファイルが含まれてます。prometheus serviceを起動するだけです。
- docker-compose.yaml…`node_exporter`と`prometheus-server`の設定が入ってます
- config/prometheus.yml…prometheus serverの設定です
- config/rules.yml…PrometheusのAlert Rule設定です
- config/alertmanager.yml…Alertmanagerの設定です、Slackでの通知設定です
- node-exporter-volume…node-exporterコンテナの`/volume_dir`にマウントされます。ファイルを置いたりして、メトリックの変動を確認できます
- prometheus-data…prometheusのデータが入ります

### Linux-structure
[Linuxのしくみ](https://gihyo.jp/book/2022/978-4-297-13148-7)を実施するための環境です。