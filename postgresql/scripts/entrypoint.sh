#!/usr/bin/env bash

if [ -z "$(ls -A $PGDATA)" ]; then
  initdb -E UTF8 --locale=C
  pg_ctl -w start -D ${PGDATA} "-o -c config_file=/etc/postgresql/postgresql.conf"
  psql -f /init/init.sql
fi

exec "$@"