# Prometheus
Prometheusの公式イメージを使ってServerたてます

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