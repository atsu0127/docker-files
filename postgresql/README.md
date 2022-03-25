# postgresql 検証用スクリプト

docker で postgresql の検証をするためのスクリプトと手順群です

## コンテナの作り方

以下でできます

```bash
docker-compose build
docker-compose up -d
docker exec -it <コンテナ名> /bin/bash
```

消したかったら以下

```bash
docker-compose down -v
```

## PITR の検証手順

[手順](./examples/pitr.md)
