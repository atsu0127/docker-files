FROM postgres:13.5-alpine
ENV LANG ja_JP.utf8

COPY ./config/postgresql.conf /etc/postgresql/postgresql.conf

CMD ["-c", "config_file=/etc/postgresql/postgresql.conf"]