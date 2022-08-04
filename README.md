# docker-files
Docker用のファイルを置いておきます

## 概要
### postgresql
以下のファイルが含まれています。`backup/restore`などのPoCのために使います。
- Dockefile…`config/postgresql.conf`を配置します
- docker-compose.yaml…基本的に永続化はしないで、コンテナ内で検証する方針です

### SQL\*Plus
以下のファイルが含まれています。M1 Macにsqlplus入れるのがだるくて作りました。
- Dockerfile…sqlplusできるコンテナイメージ作ります、`admin`というフォルダに`tnsnames.ora`とか`sqlnet.ora`とか格納してください。

### Prometheus
以下のファイルが含まれてます。prometheus serviceを起動するだけです。
- docker-compose.yaml…`node_exporter`と`prometheus-server`の設定が入ってます
- config/prometheus.yml…prometheus serverの設定です
- node-exporter-volume…node-exporterコンテナの`/volume_dir`にマウントされます。ファイルを置いたりして、メトリックの変動を確認できます。
- prometheus-data…prometheusのデータが入ります。