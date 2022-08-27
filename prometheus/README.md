# Prometheus
Prometheusの公式イメージを使ってServerたてます

## 構成
以下のコンポーネントがあります。気が向いたら増やします。
- prometheus
- alertmanager
- node-exporter
- grafana

## 使い方

### 下準備
#### prometheusの設定
`config/prometheus.yml`を適当に書き換えてください

alertのruleは`config/rule.yml`に書いてください。

#### Alertmanagerの設定
`config/alertmanager.yml`を適当に書き換えてください。

### 起動

以下で起動します

```bash
docker-compose up -d
```

その後`http://localhost:9090`にアクセスしてください。

grafanaにアクセスする場合は`http://localhost:3000`にアクセスしてください。

### grafanaの設定
grafanaにアクセスし`admin/admin`でログインする。

その後DataSourceで`http://prometheus-server:9090`を指定してください。

あとは適当にDashboard作ってください。
