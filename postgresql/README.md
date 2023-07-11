# postgresql 検証用スクリプト

docker で postgresql の検証をするためのスクリプトと手順群です

## コンテナの作り方

以下でできます

```bash
# コンテナ実行
docker build -t postgresql:latest .
CONT=`docker run -it -d postgresql:latest`

# コンテナ名確認
docker ps

# コンテナアクセス
docker exec -it ${CONT} bash

# psqlアクセス
su - postgres
psql
```

消したかったら以下

```bash
docker stop $CONT && docker rm $CONT
```

## PITR の検証手順

[手順](./examples/pitr.md)

## Cluster 化の効果検証

[手順](./examples/cluster.md)
