# docker-files
Docker用のファイルを置いておきます

## 概要
### postgresql
以下のファイルが含まれています。`backup/restore`などのPoCのために使います。
- Dockefile…`config/postgresql.conf`を配置します
- docker-compose.yaml…基本的に永続化はしないで、コンテナ内で検証する方針です
