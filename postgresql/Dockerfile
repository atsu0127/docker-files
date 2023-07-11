FROM rockylinux:8.8

# 必要なパッケージ
RUN dnf install -y epel-release && \
    dnf install -y gcc readline-devel zlib-devel wget make sudo procps-ng supervisor

# root
RUN echo "root:root" | chpasswd

# ユーザ作って権限つける
RUN groupadd -g 1101 postgres && \
    useradd -u 1101 -g postgres -G postgres -d /var/lib/pgsql postgres && \
    echo "postgres:postgres" | chpasswd && \
    chown -R postgres:postgres /var/lib/pgsql && \
    chmod -R 755 /var/lib/pgsql && \
    mkdir /workspace && \
    chown -R postgres:postgres /workspace && \
    chmod -R 755 /workspace && \
    mkdir /var/run/postgresql && \
    chown -R postgres:postgres /var/run/postgresql && \
    chmod 700 /var/run/postgresql

# ユーザかえる
WORKDIR /workspace
USER postgres

# postgresql
RUN wget https://download.postgresql.org/pub/source/v13.5/postgresql-13.5.tar.gz && \
    tar zxvf postgresql-13.5.tar.gz && \
    cd postgresql-13.5 && \
    ./configure --prefix=/var/lib/pgsql/13 && \
    make && \
    make install && \
    cd contrib && \
    make && \
    make install && \
    cd ..

# 環境変数
ENV PATH $PATH:/var/lib/pgsql/13/bin/
ENV PGDATA /var/lib/pgsql/13/data
ENV PGHOST /var/run/postgresql

# 起動用ファイル配置
COPY --chown=postgres:postgres ./scripts/*.sql /init/
COPY --chown=postgres:postgres ./config/postgresql.conf /etc/postgresql/postgresql.conf
RUN initdb -E UTF8 --locale=C && \
    pg_ctl -w start -D ${PGDATA} "-o -c config_file=/etc/postgresql/postgresql.conf" && \
    psql -f /init/init.sql && \
    echo 'export PATH=${PATH}:/var/lib/pgsql/13/bin/' >> ~/.bashrc && \
    echo 'export PGHOST=/var/run/postgresql' >> ~/.bashrc && \
    echo 'export PGDATA=/var/lib/pgsql/13/data' >> ~/.bashrc

# スタート
WORKDIR /
USER root
COPY ./config/supervisord.conf /etc/
EXPOSE 5432
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]