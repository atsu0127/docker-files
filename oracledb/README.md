# oracledb

23c 検証用の Docker 環境

## 内容

以下の container が作成されます

- oracledb…Oracle Database 23c Free
- ords

### docker-compose について

- oracledb
  - healthcheck 用のファイルをマウントしています
- ords
  - oracledb の sys ユーザにアクセスできるようになったらコンテナ実行するようにします
  - Started になった後に ords の install & 起動があるので、log を確認してお待ちください
  - 以下の文言が出力されたら`http://localhost:8080/ords/sql-developer`にアクセスして利用開始できます
    - ユーザは pdbadmin、パスワードは oracle です。

```bash
ORDS has been successfully configured.
```
